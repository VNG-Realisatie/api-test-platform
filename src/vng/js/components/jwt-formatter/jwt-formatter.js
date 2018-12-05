import BEM from 'bem.js';


/** @const {string} */
const BLOCK_JWT_FORMATTER = 'jwt-formatter';

/** @const {NodeList} */
const JWT_FORMATTERS = BEM.getBEMNodes(BLOCK_JWT_FORMATTER);

/** @const {string} */
const ELEMENT_PART = 'part';

/** @const {string} */
const MODIFIER_HEADER = 'header';

/** @const {string} */
const MODIFIER_PAYLOAD ='payload';

/** @const {string} */
const MODIFIER_SIGNATURE = 'signature';

/** @const {RegExp} */
const REGEXP_MATCH_JWT = /([a-zA-Z0-9\-_]+?)\.([a-zA-Z0-9\-_]+?)\.([a-zA-Z0-9\-_]+)?/;


/**
 * Contains logic to format JWT strings.
 * @class
 */
class JWTFormatter {
    /**
     * Constructor method.
     */
    constructor(node) {
        /** @type {HTMLElement} */
        this.node = node;

        this.format();
    }

    /**
     * Formats JWT strings.
     */
    format() {
        this.node.innerHTML = this.node.innerHTML.replace(REGEXP_MATCH_JWT, this.process.bind(this));
    }

    /**
     * Callback for regex replace matching REGEXP_MATCH_JWT.
     * @param {string} match
     * @param {string} group1
     * @param {string} group2
     * @param {string} group3
     * @returns {string}
     */
    process(match, group1, group2, group3) {
        let classNamePart1 = BEM.getBEMClassName(BLOCK_JWT_FORMATTER, ELEMENT_PART, MODIFIER_HEADER);
        let classNamePart2 = BEM.getBEMClassName(BLOCK_JWT_FORMATTER, ELEMENT_PART, MODIFIER_PAYLOAD);
        let classNamePart3 = BEM.getBEMClassName(BLOCK_JWT_FORMATTER, ELEMENT_PART, MODIFIER_SIGNATURE);
        return `<span class="${classNamePart1}">${group1}</span>.<span class="${classNamePart2}">${group2}</span>.<span class="${classNamePart3}">${group3}</span>`;
    }
}


// Start!
[...JWT_FORMATTERS].forEach(jwtFormatter => new JWTFormatter(jwtFormatter));
