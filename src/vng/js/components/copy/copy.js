import BEM from 'bem.js';
import ClipboardJS from 'clipboard';


/** @const {string} */
const BLOCK_COPY = 'copy';

/** @const {string} */
const ELEMENT_BUTTON = 'button';

/** @ocnst {NodeList} */
const COPIES = BEM.getBEMNodes(BLOCK_COPY);


/**
 * Contains logic for copy buttons.
 * @class
 */
class Copy {
    /**
     * Constructor method.
     * @param {HTMLElement} node
     */
    constructor(node) {
        /** @type {HTMLElement} */
        this.node = node;

        /** @type {HTMLElement} */
        this.button = BEM.getChildBEMNode(this.node, BLOCK_COPY, ELEMENT_BUTTON);

        new ClipboardJS(this.button);
    }
}


// Start!
[...COPIES].forEach(copy => new Copy(copy));
