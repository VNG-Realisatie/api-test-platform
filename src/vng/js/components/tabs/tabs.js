import BEM from 'bem.js';

/** @const {string} */
const BLOCK_TABS = 'tabs';

/** @const {string} */
const ELEMENT_LIST_ITEM = 'list-item';

/** @const {string} */
const ELEMENT_LINK = 'link';

/** @const {string} */
const ELEMENT_TRACK = 'track';

/** @const {string} */
const ELEMENT_TAB = 'tab';

/** @const {string} */
const MODIFIER_ACTIVE = 'active';

/** @const {NodeList} */
const TABS = BEM.getBEMNodes(BLOCK_TABS);


/**
 * Contains logic for tabs.
 * @class
 */
class Tabs {
    /**
     * Constructor method.
     * @param {HTMLElement} node
     */
    constructor(node) {
        /** @type {HTMLElement} */
        this.node = node;

        /** @type {NodeList} */
        this.listItems = BEM.getChildBEMNodes(this.node, BLOCK_TABS, ELEMENT_LIST_ITEM);

        /** @type {NodeList} */
        this.links = BEM.getChildBEMNodes(this.node, BLOCK_TABS, ELEMENT_LINK);

        /** @type {NodeList} */
        this.track = BEM.getChildBEMNode(this.node, BLOCK_TABS, ELEMENT_TRACK);

        /** @type {NodeList} */
        this.tabs = BEM.getChildBEMNodes(this.node, BLOCK_TABS, ELEMENT_TAB);

        this.bindEvents();
        this.activateCurrentTab();
    }

    /**
     * Binds events to callbacks.
     */
    bindEvents() {
        [...this.links].forEach(link => this.bindLink(link));
        window.addEventListener('resize', this.activateCurrentTab.bind(this));
    }

    /**
     * Binds link click to callback.
     * @param {HTMLAnchorElement} link
     */
    bindLink(link) {
        link.addEventListener('click', this.onClick.bind(this));
    }

    /**
     * (Re)activates the active tab, or the first tab.
     */
    activateCurrentTab() {
        let id = this.getActiveTabId();
        if (id) {
            this.activateTab(id);
        }
    }

    /**
     * Returns the active tab id (this.node.dataset.tabId) or the first tab's id.
     * @returns {(string|void)}
     */
    getActiveTabId() {
        let tabId = this.node.dataset.tabId;

        if (tabId) {
            return tabId;
        } else {
            try {
                return this.tabs[0].id;
            } catch (e) {}
        }

    }

    /**
     * Handles link click event.
     * @param {MouseEvent} e
     */
    onClick(e) {
        e.preventDefault();
        let link = e.target;
        let id = link.attributes.href.value.replace('#', '');
        this.activateTab(id);
    }

    /**
     * Activates tab with id.
     */
    activateTab(id) {
        let link = [...this.links].find(link => link.attributes.href.value === '#' + id);
        let listItem = this.getListItemByLink(link);
        let tabIndex = [...this.tabs].findIndex(tab => tab.id === id);
        let tab = this.tabs[tabIndex];

        [...this.listItems, ...this.tabs].forEach(node => BEM.removeModifier(node, MODIFIER_ACTIVE));
        [listItem, tab].forEach(node => BEM.addModifier(node, MODIFIER_ACTIVE));

        let offset = -tabIndex * this.track.clientWidth;
        [...this.tabs].forEach(tab => tab.style.transform = `translateX(${offset}px)`);

        this.node.dataset.tabId = id;
    }

    /**
     * Finds the list item containing link up the DOM tree.
     * @param {HTMLAnchorElement} link
     */
    getListItemByLink(link) {
        let listItemClassName = BEM.getBEMClassName(BLOCK_TABS, ELEMENT_LIST_ITEM);
        let i = 0;

        while (!link.classList.contains(listItemClassName)) {
            link = link.parentElement;

            if (i > 100) {
                console.error('Failed to find list item');
                break;
            }
        }
        return link;
    }
}


// Start!
[...TABS].forEach(tabs => new Tabs(tabs));
