import type * as html from 'vscode-html-languageservice';
import type { PugDocument } from '../pugDocument';
export declare function register(): (pugDoc: PugDocument) => html.FoldingRange[];
