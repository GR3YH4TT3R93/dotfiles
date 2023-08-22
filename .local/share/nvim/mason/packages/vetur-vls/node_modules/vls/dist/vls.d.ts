import * as vscode_languageserver_types from 'vscode-languageserver-types';
import { Range, Position, Definition, Diagnostic, FormattingOptions, CodeActionContext, CodeAction, CompletionList, CompletionItem, Hover, SignatureHelp, DocumentHighlight, SymbolInformation, DocumentLink, Location, TextEdit, ColorInformation, Color, ColorPresentation, FoldingRange, TextDocumentEdit, DocumentUri, MarkedString, MarkupContent as MarkupContent$1, CompletionItemKind } from 'vscode-languageserver-types';
import { TextDocument } from 'vscode-languageserver-textdocument';
import ts, { CancellationToken as CancellationToken$1 } from 'typescript';
import prettier from 'prettier';
import prettyHTML from '@starptech/prettyhtml';
import prettierEslint from 'prettier-eslint';
import * as prettierTslint from 'prettier-tslint';
import stylusSupremacy, { FormattingOptions as FormattingOptions$1 } from 'stylus-supremacy';
import * as prettierPluginPug from '@prettier/plugin-pug';
import * as vscode_languageserver from 'vscode-languageserver';
import { CancellationToken, CancellationTokenSource, Range as Range$1, Connection, FileRename, DocumentFormattingParams, TextEdit as TextEdit$1, CompletionParams, CompletionList as CompletionList$1, CompletionItem as CompletionItem$1, TextDocumentPositionParams, Hover as Hover$1, DocumentHighlight as DocumentHighlight$1, Definition as Definition$1, Location as Location$1, DocumentLinkParams, DocumentLink as DocumentLink$1, DocumentSymbolParams, SymbolInformation as SymbolInformation$1, DocumentColorParams, ColorInformation as ColorInformation$1, ColorPresentationParams, ColorPresentation as ColorPresentation$1, SignatureHelp as SignatureHelp$1, FoldingRangeParams, FoldingRange as FoldingRange$1, CodeActionParams, CodeAction as CodeAction$1, TextDocumentEdit as TextDocumentEdit$1, SemanticTokensParams, SemanticTokensRangeParams, SemanticTokens, Diagnostic as Diagnostic$1, InitializeParams, RenameFilesParams, ExecuteCommandParams, ServerCapabilities, MarkupContent, CodeActionKind, SemanticTokensLegend, CompletionItemKind as CompletionItemKind$1, SymbolKind } from 'vscode-languageserver';
import lex, { Loc } from 'pug-lexer';
import { AST } from 'vue-eslint-parser';
import * as vscode_css_languageservice from 'vscode-css-languageservice';
import { Position as Position$1, TextEdit as TextEdit$2, IPropertyData, IAtDirectiveData, IPseudoClassData, IPseudoElementData } from 'vscode-css-languageservice';
import * as emmet from 'vscode-emmet-helper';
import { ESLint } from 'eslint';

interface VLSFormatConfig {
    defaultFormatter: {
        [lang: string]: string;
    };
    defaultFormatterOptions: {
        [lang: string]: any;
    };
    scriptInitialIndent: boolean;
    styleInitialIndent: boolean;
    options: {
        tabSize: number;
        useTabs: boolean;
    };
}
interface VLSConfig {
    vetur: {
        ignoreProjectWarning: boolean;
        useWorkspaceDependencies: boolean;
        completion: {
            autoImport: boolean;
            tagCasing: 'initial' | 'kebab';
            scaffoldSnippetSources: {
                workspace: string;
                user: string;
                vetur: string;
            };
        };
        grammar: {
            customBlocks: {
                [lang: string]: string;
            };
        };
        validation: {
            template: boolean;
            templateProps: boolean;
            interpolation: boolean;
            style: boolean;
            script: boolean;
        };
        format: {
            enable: boolean;
            options: {
                tabSize: number;
                useTabs: boolean;
            };
            defaultFormatter: {
                [lang: string]: string;
            };
            defaultFormatterOptions: {
                [lang: string]: {};
            };
            scriptInitialIndent: boolean;
            styleInitialIndent: boolean;
        };
        languageFeatures: {
            codeActions: boolean;
            updateImportOnFileMove: boolean;
            semanticTokens: boolean;
        };
        trace: {
            server: 'off' | 'messages' | 'verbose';
        };
        dev: {
            vlsPath: string;
            vlsPort: number;
            logLevel: 'INFO' | 'DEBUG';
        };
        experimental: {
            templateInterpolationService: boolean;
        };
    };
}
interface VLSFullConfig extends VLSConfig {
    emmet?: any;
    html?: any;
    css?: any;
    sass?: any;
    javascript?: any;
    typescript?: any;
    prettier?: any;
    stylusSupremacy?: any;
    languageStylus?: any;
}
declare function getDefaultVLSConfig(): VLSFullConfig;
interface BasicComponentInfo {
    name: string;
    path: string;
}
type Glob = string;
interface VeturProject<C = BasicComponentInfo | Glob> {
    root: string;
    package?: string;
    tsconfig?: string;
    snippetFolder: string;
    globalComponents: C[];
}
interface VeturFullConfig {
    settings: Record<string, boolean | string | number>;
    projects: VeturProject<BasicComponentInfo>[];
}
type VeturConfig = Partial<Pick<VeturFullConfig, 'settings'>> & {
    projects?: Array<string | (Pick<VeturProject, 'root'> & Partial<VeturProject>)>;
};
declare function getVeturFullConfig(rootPathForConfig: string, workspacePath: string, veturConfig: VeturConfig): Promise<VeturFullConfig>;

declare const enum DEBUG_LEVEL {
    DEBUG = 0,
    INFO = 1
}
declare const logger: {
    _level: DEBUG_LEVEL;
    setLevel(level: string): void;
    logDebug(msg: string): void;
    logInfo(msg: string): void;
};

type RegionType$1 = 'template' | 'script' | 'style' | 'custom';
type RegionAttrKey = 'setup' | 'module' | 'scoped' | 'lang';
type RegionAttrs = Partial<Record<RegionAttrKey, boolean | string>> & Partial<Record<string, boolean | string>>;
interface EmbeddedRegion {
    languageId: LanguageId;
    start: number;
    end: number;
    type: RegionType$1;
    attrs: RegionAttrs;
}
declare function parseVueDocumentRegions(document: TextDocument): {
    regions: EmbeddedRegion[];
    importedScripts: string[];
};

type LanguageId = 'vue' | 'vue-html' | 'pug' | 'css' | 'postcss' | 'scss' | 'sass' | 'less' | 'stylus' | 'javascript' | 'typescript' | 'tsx' | 'unknown';
interface LanguageRange extends Range {
    languageId: LanguageId;
    attrs: RegionAttrs;
}
interface VueDocumentRegions {
    /**
     * Get a document where all regions of `languageId` is preserved
     * Whereas other regions are replaced with whitespaces
     */
    getSingleLanguageDocument(languageId: LanguageId): TextDocument;
    /**
     * Get a document where all regions of `type` RegionType is preserved
     * Whereas other regions are replaced with whitespaces
     */
    getSingleTypeDocument(type: RegionType): TextDocument;
    /**
     * Get a list of ranges that has `RegionType`
     */
    getLanguageRangesOfType(type: RegionType): LanguageRange[];
    /**
     * Get all language ranges inside document
     */
    getAllLanguageRanges(): LanguageRange[];
    /**
     * Get language for determining
     */
    getLanguageAtPosition(position: Position): LanguageId;
    getLanguageRangeAtPosition(position: Position): LanguageRange | null;
    getImportedScripts(): string[];
}
type RegionType = 'template' | 'script' | 'style' | 'custom';
declare function getVueDocumentRegions(document: TextDocument): VueDocumentRegions;
declare function getSingleLanguageDocument(document: TextDocument, regions: EmbeddedRegion[], languageId: LanguageId): TextDocument;
declare function getSingleTypeDocument(document: TextDocument, regions: EmbeddedRegion[], type: RegionType): TextDocument;
declare function getLanguageRangesOfType(document: TextDocument, regions: EmbeddedRegion[], type: RegionType): LanguageRange[];

interface DocumentContext {
    resolveReference(ref: string, base?: string): string;
}
declare enum CodeActionDataKind {
    CombinedCodeFix = 0,
    RefactorAction = 1,
    OrganizeImports = 2
}
interface BaseCodeActionData {
    uri: string;
    languageId: LanguageId;
    kind: CodeActionDataKind;
    textRange: {
        pos: number;
        end: number;
    };
}
interface RefactorActionData extends BaseCodeActionData {
    kind: CodeActionDataKind.RefactorAction;
    refactorName: string;
    actionName: string;
    description: string;
    notApplicableReason?: string;
}
interface CombinedFixActionData extends BaseCodeActionData {
    kind: CodeActionDataKind.CombinedCodeFix;
    fixId: {};
}
interface OrganizeImportsActionData extends BaseCodeActionData {
    kind: CodeActionDataKind.OrganizeImports;
}
type CodeActionData = RefactorActionData | CombinedFixActionData | OrganizeImportsActionData;
interface SemanticTokenClassification {
    classificationType: number;
    modifierSet: number;
}
interface SemanticTokenData extends SemanticTokenClassification {
    line: number;
    character: number;
    length: number;
}
interface SemanticTokenOffsetData extends SemanticTokenClassification {
    start: number;
    length: number;
}

interface LanguageModelCache<T> {
    /**
     * - Feed updated document
     * - Use `parse` function to re-compute model
     * - Return re-computed model
     */
    refreshAndGet(document: TextDocument): T;
    onDocumentRemoved(document: TextDocument): void;
    dispose(): void;
}
declare function getLanguageModelCache<T>(maxEntries: number, cleanupIntervalTimeInSec: number, parse: (document: TextDocument) => T): LanguageModelCache<T>;

/**
 * State associated with a specific Vue file
 * The state is shared between different modes
 */
interface VueFileInfo {
    /**
     * The default export component info from script section
     */
    componentInfo: ComponentInfo;
}
interface ComponentInfo {
    name?: string;
    definition?: Definition;
    insertInOptionAPIPos?: number;
    componentsDefine?: {
        start: number;
        end: number;
        insertPos: number;
    };
    childComponents?: ChildComponent[];
    emits?: EmitInfo[];
    /**
     * Todo: Extract type info in cases like
     * props: {
     *   foo: String
     * }
     */
    props?: PropInfo[];
    data?: DataInfo[];
    computed?: ComputedInfo[];
    methods?: MethodInfo[];
}
interface ChildComponent {
    name: string;
    documentation?: string;
    definition?: {
        path: string;
        start: number;
        end: number;
    };
    global: boolean;
    info?: VueFileInfo;
}
interface EmitInfo {
    name: string;
    /**
     * `true` if
     * emits: {
     *   foo: (...) => {...}
     * }
     *
     * `false` if
     * - `emits: ['foo']`
     * - `@Emit()`
     * - `emits: { foo: null }`
     */
    hasValidator: boolean;
    documentation?: string;
    typeString?: string;
}
interface PropInfo {
    name: string;
    /**
     * `true` if
     * props: {
     *   foo: { ... }
     * }
     *
     * `false` if
     * - `props: ['foo']`
     * - `props: { foo: String }`
     *
     */
    hasObjectValidator: boolean;
    required: boolean;
    isBoundToModel: boolean;
    documentation?: string;
    typeString?: string;
}
interface DataInfo {
    name: string;
    documentation?: string;
}
interface ComputedInfo {
    name: string;
    documentation?: string;
}
interface MethodInfo {
    name: string;
    documentation?: string;
}
declare class VueInfoService {
    private languageModes;
    private vueFileInfo;
    constructor();
    init(languageModes: LanguageModes): void;
    updateInfo(doc: TextDocument, info: VueFileInfo): void;
    getInfo(doc: TextDocument): VueFileInfo | undefined;
}

declare function createNodeModulesPaths(rootPath: string): string[];
interface Dependency<M> {
    dir: string;
    version: string;
    bundled: boolean;
    module: M;
}
interface RuntimeLibrary {
    typescript: typeof ts;
    prettier: typeof prettier;
    '@starptech/prettyhtml': typeof prettyHTML;
    'prettier-eslint': typeof prettierEslint;
    'prettier-tslint': typeof prettierTslint;
    'stylus-supremacy': typeof stylusSupremacy;
    '@prettier/plugin-pug': typeof prettierPluginPug;
}
interface DependencyService {
    readonly useWorkspaceDependencies: boolean;
    readonly nodeModulesPaths: string[];
    get<L extends keyof RuntimeLibrary>(lib: L, filePath?: string): Dependency<RuntimeLibrary[L]>;
    getBundled<L extends keyof RuntimeLibrary>(lib: L): Dependency<RuntimeLibrary[L]>;
}
declare const createDependencyService: (rootPathForConfig: string, workspacePath: string, useWorkspaceDependencies: boolean, nodeModulesPaths: string[], tsSDKPath?: string) => Promise<DependencyService>;

interface VCancellationToken extends CancellationToken {
    tsToken: CancellationToken$1;
}
declare class VCancellationTokenSource extends CancellationTokenSource {
    get token(): VCancellationToken;
}
declare function isVCancellationRequested(token?: VCancellationToken): Promise<unknown>;

declare enum VueVersion {
    VPre25 = 0,
    V25 = 1,
    V30 = 2
}
declare function getVueVersionKey(version: VueVersion): string;
declare function inferVueVersion(packagePath: string | undefined): VueVersion;

interface EnvironmentService {
    configure(config: VLSFullConfig): void;
    getConfig(): VLSFullConfig;
    getRootPathForConfig(): string;
    getProjectRoot(): string;
    getTsConfigPath(): string | undefined;
    getPackagePath(): string | undefined;
    getVueVersion(): VueVersion;
    getSnippetFolder(): string;
    getGlobalComponentInfos(): BasicComponentInfo[];
}
declare function createEnvironmentService(rootPathForConfig: string, projectPath: string, tsconfigPath: string | undefined, packagePath: string | undefined, snippetFolder: string, globalComponentInfos: BasicComponentInfo[], initialConfig: VLSConfig): EnvironmentService;

interface RefTokensService {
    send(uri: string, tokens: Range$1[]): void;
}
declare function createRefTokensService(conn: Connection): {
    send(uri: string, tokens: Range$1[]): void;
};

interface VLSServices {
    dependencyService: DependencyService;
    infoService: VueInfoService;
    refTokensService: RefTokensService;
}
interface LanguageMode {
    getId(): string;
    updateFileInfo?(doc: TextDocument): void;
    doValidation?(document: TextDocument, cancellationToken?: VCancellationToken): Promise<Diagnostic[]>;
    getCodeActions?(document: TextDocument, range: Range, formatParams: FormattingOptions, context: CodeActionContext): CodeAction[];
    doCodeActionResolve?(document: TextDocument, action: CodeAction): CodeAction;
    doComplete?(document: TextDocument, position: Position): CompletionList;
    doResolve?(document: TextDocument, item: CompletionItem): CompletionItem;
    doHover?(document: TextDocument, position: Position): Hover;
    doSignatureHelp?(document: TextDocument, position: Position): SignatureHelp | null;
    findDocumentHighlight?(document: TextDocument, position: Position): DocumentHighlight[];
    findDocumentSymbols?(document: TextDocument): SymbolInformation[];
    findDocumentLinks?(document: TextDocument, documentContext: DocumentContext): DocumentLink[];
    findDefinition?(document: TextDocument, position: Position): Definition;
    findReferences?(document: TextDocument, position: Position): Location[];
    format?(document: TextDocument, range: Range, options: FormattingOptions): TextEdit[];
    findDocumentColors?(document: TextDocument): ColorInformation[];
    getColorPresentations?(document: TextDocument, color: Color, range: Range): ColorPresentation[];
    getFoldingRanges?(document: TextDocument): FoldingRange[];
    getRenameFileEdit?(renames: FileRename): TextDocumentEdit[];
    getSemanticTokens?(document: TextDocument, range?: Range): SemanticTokenData[];
    onDocumentChanged?(filePath: string): void;
    onDocumentRemoved(document: TextDocument): void;
    dispose(): void;
}
interface LanguageModeRange extends LanguageRange {
    mode: LanguageMode;
}
declare class LanguageModes {
    private modes;
    private documentRegions;
    private modelCaches;
    private serviceHost;
    constructor();
    init(env: EnvironmentService, services: VLSServices, globalSnippetDir?: string): Promise<void>;
    getModeAtPosition(document: TextDocument, position: Position): LanguageMode | undefined;
    getAllLanguageModeRangesInDocument(document: TextDocument): LanguageModeRange[];
    getAllModes(): LanguageMode[];
    getMode(languageId: LanguageId): LanguageMode | undefined;
    onDocumentRemoved(document: TextDocument): void;
    dispose(): void;
}

declare const NULL_HOVER: {
    contents: never[];
};
declare const NULL_SIGNATURE: null;
declare const NULL_COMPLETION: CompletionList;
declare const nullMode: LanguageMode;

/**
 * Service responsible for managing documents being syned through LSP
 * Todo - Switch to incremental sync
 */
declare class DocumentService {
    private documents;
    constructor(conn: Connection);
    getDocument(uri: string): TextDocument | undefined;
    getAllDocuments(): TextDocument[];
    get onDidChangeContent(): vscode_languageserver.Event<vscode_languageserver.TextDocumentChangeEvent<TextDocument>>;
    get onDidClose(): vscode_languageserver.Event<vscode_languageserver.TextDocumentChangeEvent<TextDocument>>;
}

interface ProjectService {
    env: EnvironmentService;
    languageModes: LanguageModes;
    onDocumentFormatting(params: DocumentFormattingParams): Promise<TextEdit$1[]>;
    onCompletion(params: CompletionParams): Promise<CompletionList$1>;
    onCompletionResolve(item: CompletionItem$1): Promise<CompletionItem$1>;
    onHover(params: TextDocumentPositionParams): Promise<Hover$1>;
    onDocumentHighlight(params: TextDocumentPositionParams): Promise<DocumentHighlight$1[]>;
    onDefinition(params: TextDocumentPositionParams): Promise<Definition$1>;
    onReferences(params: TextDocumentPositionParams): Promise<Location$1[]>;
    onDocumentLinks(params: DocumentLinkParams): Promise<DocumentLink$1[]>;
    onDocumentSymbol(params: DocumentSymbolParams): Promise<SymbolInformation$1[]>;
    onDocumentColors(params: DocumentColorParams): Promise<ColorInformation$1[]>;
    onColorPresentations(params: ColorPresentationParams): Promise<ColorPresentation$1[]>;
    onSignatureHelp(params: TextDocumentPositionParams): Promise<SignatureHelp$1 | null>;
    onFoldingRanges(params: FoldingRangeParams): Promise<FoldingRange$1[]>;
    onCodeAction(params: CodeActionParams): Promise<CodeAction$1[]>;
    onCodeActionResolve(action: CodeAction$1): Promise<CodeAction$1>;
    onWillRenameFile(fileRename: FileRename): Promise<TextDocumentEdit$1[]>;
    onSemanticTokens(params: SemanticTokensParams | SemanticTokensRangeParams): Promise<SemanticTokens>;
    doValidate(doc: TextDocument, cancellationToken?: VCancellationToken): Promise<Diagnostic$1[] | null>;
    dispose(): Promise<void>;
}
declare function createProjectService(env: EnvironmentService, documentService: DocumentService, globalSnippetDir: string | undefined, dependencyService: DependencyService, refTokensService: RefTokensService): Promise<ProjectService>;

declare class VLS {
    private lspConnection;
    private workspaces;
    private nodeModulesMap;
    private documentService;
    private globalSnippetDir;
    private loadingProjects;
    private projects;
    private pendingValidationRequests;
    private cancellationTokenValidationRequests;
    private validationDelayMs;
    private documentFormatterRegistration;
    private workspaceConfig;
    constructor(lspConnection: Connection);
    init(params: InitializeParams): Promise<{
        capabilities: {};
    } | undefined>;
    listen(): void;
    private getVLSFullConfig;
    private addWorkspace;
    private setupWorkspaceListeners;
    private setupConfigListeners;
    private getAllProjectConfigs;
    private warnProjectIfNeed;
    getProjectRootPath(uri: DocumentUri): string | undefined;
    private getProjectConfig;
    private getProjectService;
    private setupLSPHandlers;
    private setupCustomLSPHandlers;
    private setupDynamicFormatters;
    private setupFileChangeListeners;
    /**
     * Custom Notifications
     */
    openWebsite(url: string): void;
    /**
     * Language Features
     */
    onDocumentFormatting(params: DocumentFormattingParams): Promise<TextEdit[]>;
    onCompletion(params: CompletionParams): Promise<CompletionList>;
    onCompletionResolve(item: CompletionItem): Promise<CompletionItem>;
    onHover(params: TextDocumentPositionParams): Promise<Hover>;
    onDocumentHighlight(params: TextDocumentPositionParams): Promise<DocumentHighlight[]>;
    onDefinition(params: TextDocumentPositionParams): Promise<Definition>;
    onReferences(params: TextDocumentPositionParams): Promise<Location[]>;
    onDocumentLinks(params: DocumentLinkParams): Promise<DocumentLink[]>;
    onDocumentSymbol(params: DocumentSymbolParams): Promise<SymbolInformation[]>;
    onDocumentColors(params: DocumentColorParams): Promise<ColorInformation[]>;
    onColorPresentations(params: ColorPresentationParams): Promise<ColorPresentation[]>;
    onSignatureHelp(params: TextDocumentPositionParams): Promise<SignatureHelp | null>;
    onFoldingRanges(params: FoldingRangeParams): Promise<FoldingRange[]>;
    onCodeAction(params: CodeActionParams): Promise<never[] | CodeAction[]>;
    onCodeActionResolve(action: CodeAction): Promise<CodeAction>;
    onWillRenameFiles({ files }: RenameFilesParams): Promise<{
        documentChanges: vscode_languageserver_types.TextDocumentEdit[];
    } | null>;
    onSemanticToken(params: SemanticTokensParams | SemanticTokensRangeParams): Promise<SemanticTokens>;
    private triggerValidation;
    cancelPastValidation(textDocument: TextDocument): void;
    cleanPendingValidation(textDocument: TextDocument): void;
    validateTextDocument(textDocument: TextDocument, cancellationToken?: VCancellationToken): Promise<void>;
    doValidate(doc: TextDocument, cancellationToken?: VCancellationToken): Promise<vscode_languageserver_types.Diagnostic[] | null>;
    executeCommand(arg: ExecuteCommandParams): Promise<void>;
    removeDocument(doc: TextDocument): Promise<void>;
    dispose(): void;
    get capabilities(): ServerCapabilities;
}

/**
 * Vetur mainly deals with paths / uris from two objects
 *
 * - `TextDocument` from `vscode-languageserver`
 * - `SourceFile` from `typescript`
 *
 * TypeScript Language Service uses `fileName`, which is a file path without scheme.
 * Convert them into standard URI by `Uri.file`.
 *
 * ## `TextDocument.uri`
 *
 * - macOS / Linux: file:///foo/bar.vue
 * - Windows: file:///c%3A/foo/bar.vue (%3A is `:`)
 *
 * ## `SourceFile.fileName`
 *
 * - macOS / Linux: /foo/bar.vue
 * - Windows: c:/foo/bar.vue
 *
 * ## vscode-uri
 *
 * - `Uri.parse`: Takes full URI starting with `file://`
 * - `Uri.file`: Takes file path
 *
 * ### `fsPath` vs `path`
 *
 * - macOS / Linux:
 * ```
 * > Uri.parse('file:///foo/bar.vue').fsPath
 * '/foo/bar.vue'
 * > Uri.parse('file:///foo/bar.vue').path
 * '/foo/bar.vue'
 * ```
 * - Windows
 * ```
 * > Uri.parse('file:///c%3A/foo/bar.vue').fsPath
 * 'c:\\foo\\bar.vue' (\\ escapes to \)
 * > Uri.parse('file:///c%3A/foo/bar.vue').path
 * '/c:/foo/bar.vue'
 * ```
 */
declare function getFileFsPath(documentUri: string): string;
declare function getFilePath(documentUri: string): string;
declare function normalizeFileNameToFsPath(fileName: string): string;
declare function normalizeFileNameResolve(...paths: string[]): string;
declare function getPathDepth(filePath: string, sep: string): number;
declare function getFsPathToUri(fsPath: string): string;
declare function normalizeAbsolutePath(fsPath: string, root: string): string;

declare function sleep(ms: number): Promise<unknown>;

declare function getWordAtText(text: string, offset: number, wordDefinition: RegExp): {
    start: number;
    length: number;
};
declare function removeQuotes(str: string): string;
/**
 *  wrap text in section tags like <template>, <style>
 *  add leading and trailing newline and optional indentation
 */
declare function indentSection(text: string, options: VLSFormatConfig): string;
declare function toMarkupContent(value: string | MarkupContent | undefined): "" | MarkupContent;
declare function modulePathToValidIdentifier(tsModule: RuntimeLibrary['typescript'], modulePath: string, target: ts.ScriptTarget | undefined): string;

declare function findConfigFile(findPath: string, configName: string): string | undefined;
declare function requireUncached(module: string): any;

interface AutoImportSfcPlugin {
    setGetConfigure(fn: () => VLSFullConfig): void;
    setGetFilesFn(fn: () => string[]): void;
    setGetJSResolve(fn: (doc: TextDocument, item: CompletionItem$1) => CompletionItem$1): void;
    setGetTSScriptTarget(fn: () => ts.ScriptTarget | undefined): void;
    doComplete(document: TextDocument): CompletionItem$1[];
    isMyResolve(item: CompletionItem$1): boolean;
    doResolve(document: TextDocument, item: CompletionItem$1): CompletionItem$1;
}
/**
 * Auto import component in script when completion in template.
 * ## Implementation:
 * 1. Get all vue files path from ts language service host.
 * 2. Record more data in VueInfoService. Like: componentsDefine position.
 * 3. Provide completion list in template from vue files path
 * 4. Mock code to trigger auto import in TS for make importing component TextEdit.
 * 5. Add component define TextEdit from second step.
 * 6. Provide completion/resolve from fourth and fifth steps.
 *
 * ## Example
 * For mock code example in TS when componentName is `Item`.
 * The `=` is position for call completion/resolve in TS language service.
 * ```typescript
 * export default {
 *   components: {
 *     Item: ItemV=
 *   }
 * }
 * ```
 */
declare function createAutoImportSfcPlugin(tsModule: RuntimeLibrary['typescript'], vueInfoService?: VueInfoService): AutoImportSfcPlugin;

declare function getPugMode(env: EnvironmentService, dependencyService: DependencyService, documentRegions: LanguageModelCache<VueDocumentRegions>, vueInfoService?: VueInfoService): LanguageMode;

declare function findTokenAtPosition(code: string, position: Position): lex.Token | null;
declare const locToRange: (loc: Loc) => Range;

interface TSCodeActionKind {
    kind: CodeActionKind;
    matches(refactor: {
        actionName: string;
    }): boolean;
}
declare function getCodeActionKind(refactor: {
    actionName: string;
}): CodeActionKind;

interface InternalChildComponent {
    name: string;
    documentation?: string;
    definition?: {
        path: string;
        start: number;
        end: number;
    };
    defaultExportNode?: ts.Node;
}
declare function analyzeComponentsDefine(tsModule: RuntimeLibrary['typescript'], defaultExportType: ts.Type, checker: ts.TypeChecker, tagCasing?: string): {
    start: number;
    end: number;
    insertPos: number;
    list: InternalChildComponent[];
} | undefined;

declare function getComponentInfo(tsModule: RuntimeLibrary['typescript'], service: ts.LanguageService, fileFsPath: string, globalComponentInfos: BasicComponentInfo[], vueVersion: VueVersion, config: any): VueFileInfo | undefined;
declare function analyzeDefaultExportExpr(tsModule: RuntimeLibrary['typescript'], defaultExportNode: ts.Node, checker: ts.TypeChecker, vueVersion: VueVersion): VueFileInfo;
declare function getDefaultExportNode(tsModule: RuntimeLibrary['typescript'], sourceFile: ts.SourceFile): ts.Node | undefined;
declare function getLastChild(d: ts.Declaration): ts.Node | undefined;
declare function isClassType(tsModule: RuntimeLibrary['typescript'], type: ts.Type): boolean;
declare function getClassDecoratorArgumentType(tsModule: RuntimeLibrary['typescript'], defaultExportNode: ts.Type, checker: ts.TypeChecker): ts.Type | undefined;
declare function buildDocumentation(tsModule: RuntimeLibrary['typescript'], s: ts.Symbol, checker: ts.TypeChecker): string;

declare function getGlobalComponents(tsModule: RuntimeLibrary['typescript'], service: ts.LanguageService, componentInfos: BasicComponentInfo[], tagCasing?: string): InternalChildComponent[];

interface TemplateSourceMapRange {
    start: number;
    end: number;
}
interface TemplateSourceMapNodeFrom extends TemplateSourceMapRange {
    fileName: string;
}
interface TemplateSourceMapNodeTo extends TemplateSourceMapRange {
    fileName: string;
}
interface Mapping {
    [k: number]: number;
}
/**
 * Invariants:
 *
 * - `from.end - from.start` should equal to `to.end - to.start - 5 * (to.thisDotRanges.length)`
 * - Each item in `to.thisDotRanges` should have length 5 for `this.`
 */
interface TemplateSourceMapNode {
    from: TemplateSourceMapNodeFrom;
    to: TemplateSourceMapNodeTo;
    offsetMapping: Mapping;
    offsetBackMapping: Mapping;
    mergedNodes: TemplateSourceMapNode[];
}
interface TemplateSourceMap {
    [fileName: string]: TemplateSourceMapNode[];
}
/**
 * Walk through the validSourceFile, for each Node, find its corresponding Node in syntheticSourceFile.
 *
 * Generate a SourceMap with Nodes looking like this:
 *
 * SourceMapNode {
 *   from: {
 *     start: 0,
 *     end: 8
 *     filename: 'foo.vue'
 *   },
 *   to: {
 *     start: 0,
 *     end: 18
 *     filename: 'foo.vue.template'
 *   },
 *   offsetMapping: {
 *     0: 5,
 *     1: 6,
 *     2, 7
 *   },
 * }
 */
declare function generateSourceMap(tsModule: RuntimeLibrary['typescript'], syntheticSourceFile: ts.SourceFile, validSourceFile: ts.SourceFile): TemplateSourceMapNode[];
/**
 * Map a range from actual `.vue` file to `.vue.template` file
 */
declare function mapFromPositionToOffset(document: TextDocument, position: Position, sourceMap: TemplateSourceMap): number;
/**
 * Map a range from actual `.vue` file to `.vue.template` file
 */
declare function mapToRange(toDocument: TextDocument, from: ts.TextSpan, sourceMap: TemplateSourceMap): Range;
/**
 * Map a range from virtual `.vue.template` file back to original `.vue` file
 */
declare function mapBackRange(fromDocumnet: TextDocument, to: ts.TextSpan, sourceMap: TemplateSourceMap): Range;
declare function printSourceMap(sourceMap: TemplateSourceMap, vueFileSrc: string, tsFileSrc: string): void;
declare function stringifySourceMapNodes(sourceMapNodes: TemplateSourceMapNode[], vueFileSrc: string, tsFileSrc: string): string;

declare const templateSourceMap: TemplateSourceMap;
interface IServiceHost {
    queryVirtualFileInfo(fileName: string, currFileText: string): {
        source: string;
        sourceMapNodesString: string;
    };
    updateCurrentVirtualVueTextDocument(doc: TextDocument, childComponents?: ChildComponent[]): {
        templateService: ts.LanguageService;
        templateSourceMap: TemplateSourceMap;
    };
    updateCurrentVueTextDocument(doc: TextDocument): {
        service: ts.LanguageService;
        scriptDoc: TextDocument;
    };
    getLanguageService(): ts.LanguageService;
    updateExternalDocument(filePath: string): void;
    getFileNames(): string[];
    getComplierOptions(): ts.CompilerOptions;
    dispose(): void;
}
/**
 * Manges 4 set of files
 *
 * - `vue` files in workspace
 * - `js/ts` files in workspace
 * - `vue` files in `node_modules`
 * - `js/ts` files in `node_modules`
 */
declare function getServiceHost(tsModule: RuntimeLibrary['typescript'], env: EnvironmentService, updatedScriptRegionDocuments: LanguageModelCache<TextDocument>): IServiceHost;

declare function getJavascriptMode(tsModule: RuntimeLibrary['typescript'], serviceHost: IServiceHost, env: EnvironmentService, documentRegions: LanguageModelCache<VueDocumentRegions>, dependencyService: DependencyService, globalComponentInfos: BasicComponentInfo[], vueInfoService: VueInfoService, refTokensService: RefTokensService): Promise<LanguageMode>;
declare function languageServiceIncludesFile(ls: ts.LanguageService, documentUri: string): boolean;
declare function getFormatCodeSettings(config: any): ts.FormatCodeSettings;

/**
 * Adapted from https://github.com/microsoft/vscode/blob/8ba70d8bdc3a10e3143cc4a131f333263bc48eef/extensions/typescript-language-features/src/utils/previewer.ts
 */

declare function getTagDocumentation(tag: ts.JSDocTagInfo): string | undefined;
declare function plain(parts: ts.SymbolDisplayPart[] | string): string;

/**
 * extended from https://github.com/microsoft/TypeScript/blob/35c8df04ad959224fad9037e340c1e50f0540a49/src/services/classifier2020.ts#L9
 * so that we don't have to map it into our own legend
 */
declare const enum TsTokenType {
    class = 0,
    enum = 1,
    interface = 2,
    namespace = 3,
    typeParameter = 4,
    type = 5,
    parameter = 6,
    variable = 7,
    enumMember = 8,
    property = 9,
    function = 10,
    member = 11
}
/**
 * adopted from https://github.com/microsoft/TypeScript/blob/35c8df04ad959224fad9037e340c1e50f0540a49/src/services/classifier2020.ts#L13
 * so that we don't have to map it into our own legend
 */
declare const enum TokenModifier {
    declaration = 0,
    static = 1,
    async = 2,
    readonly = 3,
    defaultLibrary = 4,
    local = 5,
    refValue = 6
}
declare function getSemanticTokenLegends(): SemanticTokensLegend;
declare function getTokenTypeFromClassification(tsClassification: number): number;
declare function getTokenModifierFromClassification(tsClassification: number): number;
declare function addCompositionApiRefTokens(tsModule: RuntimeLibrary['typescript'], program: ts.Program, fileFsPath: string, exists: SemanticTokenOffsetData[], refTokensService: RefTokensService): [number, number][];

declare enum StylePriority {
    Emmet = 0,
    Platform = 1
}

declare function getCSSMode(env: EnvironmentService, documentRegions: LanguageModelCache<VueDocumentRegions>, dependencyService: DependencyService): LanguageMode;
declare function getPostCSSMode(env: EnvironmentService, documentRegions: LanguageModelCache<VueDocumentRegions>, dependencyService: DependencyService): LanguageMode;
declare function getSCSSMode(env: EnvironmentService, documentRegions: LanguageModelCache<VueDocumentRegions>, dependencyService: DependencyService): LanguageMode;
declare function getLESSMode(env: EnvironmentService, documentRegions: LanguageModelCache<VueDocumentRegions>, dependencyService: DependencyService): LanguageMode;

declare class Node {
    start: number;
    end: number;
    children: Node[];
    parent: Node;
    tag?: string;
    closed?: boolean;
    endTagStart?: number;
    isInterpolation: boolean;
    attributes?: {
        [name: string]: string;
    };
    get attributeNames(): string[];
    constructor(start: number, end: number, children: Node[], parent: Node);
    isSameTag(tagInLowerCase: string): boolean | "" | undefined;
    get firstChild(): Node;
    get lastChild(): Node | undefined;
    findNodeBefore(offset: number): Node;
    findNodeAt(offset: number): Node;
}
interface HTMLDocument {
    roots: Node[];
    findNodeBefore(offset: number): Node;
    findNodeAt(offset: number): Node;
}
declare function parse(text: string): HTMLDocument;
declare function parseHTMLDocument(document: TextDocument): HTMLDocument;

declare class HTMLMode implements LanguageMode {
    private env;
    private dependencyService;
    private vueDocuments;
    private autoImportSfcPlugin;
    private vueInfoService?;
    private tagProviderSettings;
    private enabledTagProviders;
    private embeddedDocuments;
    private lintEngine;
    constructor(documentRegions: LanguageModelCache<VueDocumentRegions>, env: EnvironmentService, dependencyService: DependencyService, vueDocuments: LanguageModelCache<HTMLDocument>, autoImportSfcPlugin: AutoImportSfcPlugin, vueInfoService?: VueInfoService | undefined);
    getId(): string;
    doValidation(document: TextDocument, cancellationToken?: VCancellationToken): Promise<vscode_languageserver_types.Diagnostic[]>;
    doComplete(document: TextDocument, position: Position): vscode_languageserver_types.CompletionList;
    doHover(document: TextDocument, position: Position): vscode_languageserver_types.Hover;
    findDocumentHighlight(document: TextDocument, position: Position): vscode_languageserver_types.DocumentHighlight[];
    findDocumentLinks(document: TextDocument, documentContext: DocumentContext): vscode_languageserver_types.DocumentLink[];
    findDocumentSymbols(document: TextDocument): vscode_languageserver_types.SymbolInformation[];
    format(document: TextDocument, range: Range, formattingOptions: FormattingOptions): vscode_languageserver_types.TextEdit[];
    findDefinition(document: TextDocument, position: Position): vscode_languageserver_types.Location[];
    getFoldingRanges(document: TextDocument): vscode_languageserver_types.FoldingRange[];
    onDocumentChanged(filePath: string): void;
    onDocumentRemoved(document: TextDocument): void;
    dispose(): void;
}

type DocumentRegionCache = LanguageModelCache<VueDocumentRegions>;
declare class VueHTMLMode implements LanguageMode {
    private htmlMode;
    private vueInterpolationMode;
    private autoImportSfcPlugin;
    constructor(tsModule: RuntimeLibrary['typescript'], serviceHost: IServiceHost, env: EnvironmentService, documentRegions: DocumentRegionCache, autoImportSfcPlugin: AutoImportSfcPlugin, dependencyService: DependencyService, vueInfoService?: VueInfoService);
    getId(): string;
    queryVirtualFileInfo(fileName: string, currFileText: string): {
        source: string;
        sourceMapNodesString: string;
    };
    doValidation(document: TextDocument, cancellationToken?: VCancellationToken): Promise<vscode_languageserver_types.Diagnostic[]>;
    doComplete(document: TextDocument, position: Position): {
        isIncomplete: boolean;
        items: CompletionItem[];
    };
    doResolve(document: TextDocument, item: CompletionItem): CompletionItem;
    doHover(document: TextDocument, position: Position): Hover;
    findDocumentHighlight(document: TextDocument, position: Position): vscode_languageserver_types.DocumentHighlight[];
    findDocumentLinks(document: TextDocument, documentContext: DocumentContext): vscode_languageserver_types.DocumentLink[];
    findDocumentSymbols(document: TextDocument): vscode_languageserver_types.SymbolInformation[];
    format(document: TextDocument, range: Range, formattingOptions: FormattingOptions): vscode_languageserver_types.TextEdit[];
    findReferences(document: TextDocument, position: Position): Location[];
    findDefinition(document: TextDocument, position: Position): Location[];
    getFoldingRanges(document: TextDocument): vscode_languageserver_types.FoldingRange[];
    onDocumentRemoved(document: TextDocument): void;
    dispose(): void;
}

declare class VueInterpolationMode implements LanguageMode {
    private documentRegions;
    private tsModule;
    private serviceHost;
    private env;
    private vueDocuments;
    private vueInfoService?;
    constructor(documentRegions: LanguageModelCache<VueDocumentRegions>, tsModule: RuntimeLibrary['typescript'], serviceHost: IServiceHost, env: EnvironmentService, vueDocuments: LanguageModelCache<HTMLDocument>, vueInfoService?: VueInfoService | undefined);
    getId(): string;
    queryVirtualFileInfo(fileName: string, currFileText: string): {
        source: string;
        sourceMapNodesString: string;
    };
    private getChildComponents;
    private isInterpolationMode;
    doValidation(document: TextDocument, cancellationToken?: VCancellationToken): Promise<Diagnostic[]>;
    doComplete(document: TextDocument, position: Position): CompletionList;
    doResolve(document: TextDocument, item: CompletionItem): CompletionItem;
    doHover(document: TextDocument, position: Position): {
        contents: MarkedString[];
        range?: Range;
    };
    findDefinition(document: TextDocument, position: Position): Location[];
    findReferences(document: TextDocument, position: Position): Location[];
    onDocumentRemoved(): void;
    dispose(): void;
}

interface Modifier {
    label: string;
    documentation?: string | MarkupContent$1;
}
declare function getModifierProvider(): {
    eventModifiers: {
        items: {
            label: string;
            documentation: string | MarkupContent$1 | undefined;
        }[];
        priority: number;
    };
    keyModifiers: {
        items: {
            label: string;
            documentation: string | MarkupContent$1 | undefined;
        }[];
        priority: number;
    };
    mouseModifiers: {
        items: {
            label: string;
            documentation: string | MarkupContent$1 | undefined;
        }[];
        priority: number;
    };
    systemModifiers: {
        items: {
            label: string;
            documentation: string | MarkupContent$1 | undefined;
        }[];
        priority: number;
    };
    propsModifiers: {
        items: {
            label: string;
            documentation: string | MarkupContent$1 | undefined;
        }[];
        priority: number;
    };
    vModelModifiers: {
        items: {
            label: string;
            documentation: string | MarkupContent$1 | undefined;
        }[];
        priority: number;
    };
};

declare function getTagDefinition(vueFileInfo: VueFileInfo, tag: string): Location[];

interface CompletionTestSetup {
    doComplete(doc: TextDocument, pos: Position): CompletionList;
    langId: string;
    docUri: string;
}
declare function testDSL(setup: CompletionTestSetup): (text: TemplateStringsArray) => CompletionAsserter;
declare class CompletionAsserter {
    items: CompletionItem[];
    doc: TextDocument;
    lastMatch: CompletionItem;
    constructor(items: CompletionItem[], doc: TextDocument);
    count(expect: number): this;
    has(label: string): this;
    withDoc(doc: string): this;
    withKind(kind: CompletionItemKind): this;
    become(resultText: string): this;
    hasNo(label: string): this;
}

interface HoverTestSetup {
    docUri: string;
    langId: string;
    doHover(document: TextDocument, position: Position): Hover;
}
declare class HoverAsserter {
    hover: Hover;
    document: TextDocument;
    constructor(hover: Hover, document: TextDocument);
    hasNothing(): void;
    hasHoverAt(label: string, offset: number): void;
}
declare function hoverDSL(setup: HoverTestSetup): ([value]: TemplateStringsArray) => HoverAsserter;

declare function getVueMode(env: EnvironmentService, globalSnippetDir?: string): LanguageMode;

interface ScaffoldSnippetSources {
    workspace: string | undefined;
    user: string | undefined;
    vetur: string | undefined;
}
declare class SnippetManager {
    private _snippets;
    constructor(snippetFolder: string, globalSnippetDir?: string);
    completeSnippets(scaffoldSnippetSources: ScaffoldSnippetSources): CompletionItem[];
}

declare const moduleName = "vue-editor-bridge";
declare const fileName = "vue-temp/vue-editor-bridge.ts";
declare const preVue25Content: string;
declare const vue25Content: string;
declare const vue30Content: string;

declare class ModuleResolutionCache {
    private _cache;
    getCache(moduleName: string, containingFile: string): ts.ResolvedModule | undefined;
    setCache(moduleName: string, containingFile: string, cache: ts.ResolvedModule): undefined;
}

declare function parseVueScript(text: string): string;
declare function parseVueTemplate(text: string): string;
declare function createUpdater(tsModule: RuntimeLibrary['typescript'], allChildComponentsInfo: Map<string, ChildComponent[]>): {
    createLanguageServiceSourceFile: (fileName: string, scriptSnapshot: ts.IScriptSnapshot, scriptTarget: ts.ScriptTarget, version: string, setNodeParents: boolean, scriptKind?: ts.ScriptKind) => ts.SourceFile;
    updateLanguageServiceSourceFile: (sourceFile: ts.SourceFile, scriptSnapshot: ts.IScriptSnapshot, version: string, textChangeRange: ts.TextChangeRange, aggressiveChecks?: boolean) => ts.SourceFile;
};
/**
 * Wrap render function with component options in the script block
 * to validate its types
 */
declare function injectVueTemplate(tsModule: RuntimeLibrary['typescript'], sourceFile: ts.SourceFile, renderBlock: ts.Expression[], scriptSrc?: string): void;

type DiagnosticFilter = (diagnostic: ts.Diagnostic) => boolean;
declare function createTemplateDiagnosticFilter(tsModule: RuntimeLibrary['typescript']): DiagnosticFilter;

declare const renderHelperName = "__vlsRenderHelper";
declare const componentHelperName = "__vlsComponentHelper";
declare const iterationHelperName = "__vlsIterationHelper";
declare const componentDataName = "__vlsComponentData";
/**
 * Allowed global variables in templates.
 * Borrowed from: https://github.com/vuejs/vue/blob/dev/src/core/instance/proxy.js
 */
declare const globalScope: string[];
/**
 * @param tsModule Loaded TS dependency
 * @param childComponentNamesInSnakeCase If `VElement`'s name matches one of the child components'
 * name, generate expression with `${componentHelperName}__${name}`, which will enforce type-check
 * on props
 */
declare function getTemplateTransformFunctions(tsModule: RuntimeLibrary['typescript'], childComponentNamesInSnakeCase?: string[]): {
    transformTemplate: (program: AST.ESLintProgram, code: string) => ts.Expression[];
    parseExpression: (exp: string, scope: string[], start: number) => ts.Expression;
};

declare function isVueFile(path: string): boolean;
/**
 * If the path ends with `.vue.ts`, it's a `.vue` file pre-processed by Vetur
 * to be used in TS Language Service
 *
 * Note: all files outside any node_modules folder are considered,
 * EXCEPT if they are added to tsconfig via 'files' or 'include' properties
 */
declare function isVirtualVueFile(path: string, projectFiles: Set<string>): boolean;
/**
 * If the path ends with `.vue.template`, it's a `.vue` file's template part
 * pre-processed by Vetur to calculate template diagnostics in TS Language Service
 */
declare function isVirtualVueTemplateFile(path: string): boolean;
declare function findNodeByOffset(root: ts.Node, offset: number): ts.Node | undefined;
declare function toCompletionItemKind(kind: ts.ScriptElementKind): CompletionItemKind$1;
declare function toSymbolKind(kind: ts.ScriptElementKind): SymbolKind;

declare function getVueSys(tsModule: RuntimeLibrary['typescript'], scriptFileNameSet: Set<string>): ts.System;

/**
 * Walk all descendant expressions included root node naively. Not comprehensive walker.
 * Traversal type is post-order (LRN).
 * If some expression node is returned in predicate function, the node will be replaced.
 */
declare function walkExpression(tsModule: RuntimeLibrary['typescript'], root: ts.Expression, predicate: (node: ts.Expression, additionalScope: ts.Identifier[]) => ts.Expression | void): ts.Expression;

declare function prettierify(dependencyService: DependencyService, code: string, fileFsPath: string, languageId: string, range: Range, vlsFormatConfig: VLSFormatConfig, initialIndent: boolean): TextEdit[];
declare function prettierEslintify(dependencyService: DependencyService, code: string, fileFsPath: string, languageId: string, range: Range, vlsFormatConfig: VLSFormatConfig, initialIndent: boolean): TextEdit[];
declare function prettierTslintify(dependencyService: DependencyService, code: string, fileFsPath: string, languageId: string, range: Range, vlsFormatConfig: VLSFormatConfig, initialIndent: boolean): TextEdit[];
declare function prettierPluginPugify(dependencyService: DependencyService, code: string, fileFsPath: string, languageId: string, range: Range, vlsFormatConfig: VLSFormatConfig, initialIndent: boolean): TextEdit[];

declare class SassLanguageMode implements LanguageMode {
    private env;
    constructor(env: EnvironmentService);
    getId(): string;
    doComplete(document: TextDocument, position: Position$1): CompletionList;
    format(document: TextDocument, range: Range, formattingOptions: FormattingOptions): TextEdit$2[];
    onDocumentRemoved(document: TextDocument): void;
    dispose(): void;
}

declare const builtIn: CompletionItem[];

interface LoadedCSSData {
    properties: IPropertyData[];
    atDirectives: IAtDirectiveData[];
    pseudoClasses: IPseudoClassData[];
    pseudoElements: IPseudoElementData[];
}
declare const cssData: LoadedCSSData;

/**
 * Naive check whether currentWord is class or id
 * @param {String} currentWord
 * @return {Boolean}
 */
declare function isClassOrId(currentWord: string): boolean;
/**
 * Naive check whether currentWord is at rule
 * @param {String} currentWord
 * @return {Boolean}
 */
declare function isAtRule(currentWord: string): boolean;
/**
 * Naive check whether currentWord is value for given property
 * @param {Object} data
 * @param {String} currentWord
 * @return {Boolean}
 */
declare function isValue(data: LoadedCSSData, currentWord: string): boolean;
/**
 * Formats property name
 * @param {String} currentWord
 * @return {String}
 */
declare function getPropertyName(currentWord: string): string;
/**
 * Search for property in cssSchema
 * @param {Object} data
 * @param {String} property
 * @return {Object}
 */
declare function findPropertySchema(data: LoadedCSSData, property: string): vscode_css_languageservice.IPropertyData | undefined;
/**
 * Returns completion items lists from document symbols
 * @param {String} text
 * @param {String} currentWord
 * @return {CompletionItem}
 */
declare function getAllSymbols(text: string, currentWord: string, position: Position): CompletionItem[];
/**
 * Returns at rules list for completion
 * @param {Object} data
 * @param {String} currentWord
 * @return {CompletionItem}
 */
declare function getAtRules(data: LoadedCSSData, currentWord: string): CompletionItem[];
/**
 * Returns property list for completion
 * @param {Object} data
 * @param {String} currentWord
 * @return {CompletionItem}
 */
declare function getProperties(data: LoadedCSSData, currentWord: string, useSeparator: boolean): CompletionItem[];
/**
 * Returns values for current property for completion list
 * @param {Object} data
 * @param {String} currentWord
 * @return {CompletionItem}
 */
declare function getValues(data: LoadedCSSData, currentWord: string): CompletionItem[];
declare function provideCompletionItems(document: TextDocument, position: Position, useSeparator?: boolean): CompletionList;

declare const cssColors: string[];

declare function getStylusMode(env: EnvironmentService, documentRegions: LanguageModelCache<VueDocumentRegions>, dependencyService: DependencyService): LanguageMode;
declare const wordPattern: RegExp;

type NodeName = 'Ident' | 'Selector' | 'Call' | 'Function' | 'Media' | 'Keyframes' | 'Atrule' | 'Import' | 'Require' | 'Supports' | 'Literal' | 'Group' | 'Root' | 'Block' | 'Expression' | 'Rgba' | 'Property' | 'Object';
interface StylusNode {
    __type: NodeName;
    name: NodeName;
    lineno: number;
    column: number;
    segments: StylusNode[];
    expr?: StylusNode;
    val?: StylusNode;
    nodes?: StylusNode[];
    vals?: StylusNode[];
    block?: StylusNode;
    __scope?: number[];
    string?: string;
}
/**
 * Checks wether node is variable declaration
 * @param {StylusNode} node
 * @return {Boolean}
 */
declare function isVariableNode(node: StylusNode): boolean;
/**
 * Checks wether node is function declaration
 * @param {StylusNode} node
 * @return {Boolean}
 */
declare function isFunctionNode(node: StylusNode): boolean;
/**
 * Checks wether node is selector node
 * @param {StylusNode} node
 * @return {Boolean}
 */
declare function isSelectorNode(node: StylusNode): boolean;
/**
 * Checks wether node is selector call node e.g.:
 * {mySelectors}
 * @param {StylusNode} node
 * @return {Boolean}
 */
declare function isSelectorCallNode(node: StylusNode): boolean;
/**
 * Checks wether node is at rule
 * @param {StylusNode} node
 * @return {Boolean}
 */
declare function isAtRuleNode(node: StylusNode): boolean;
/**
 * Checks wether node contains color
 * @param {StylusNode} node
 * @return {Boolean}
 */
declare function isColor(node: StylusNode): boolean;
/**
 * Parses text editor content and returns ast
 * @param {string} text - text editor content
 * @return {Object}
 */
declare function buildAst(text: string): StylusNode | null;
/**
 * Flattens ast and removes useless nodes
 * @param {StylusNode} node
 * @return {Array}
 */
declare function flattenAndFilterAst(node: StylusNode, scope?: number[]): StylusNode[];
declare function findNodeAtPosition(root: StylusNode, pos: Position, needBlock?: boolean): StylusNode | null;

declare function stylusHover(document: TextDocument, position: Position): Hover;

interface IStylusSupremacy {
    createFormattingOptions(options: any): FormattingOptions$1;
    createFormattingOptionsFromStylint(options: any): FormattingOptions$1;
    format(content: string, options: FormattingOptions$1): string;
}

declare function provideDocumentSymbols(document: TextDocument): SymbolInformation[];

declare enum HtmlTokenType {
    StartCommentTag = 0,
    Comment = 1,
    EndCommentTag = 2,
    StartTagOpen = 3,
    StartTagClose = 4,
    StartTagSelfClose = 5,
    StartTag = 6,
    StartInterpolation = 7,
    EndTagOpen = 8,
    EndTagClose = 9,
    EndTag = 10,
    EndInterpolation = 11,
    DelimiterAssign = 12,
    AttributeName = 13,
    AttributeValue = 14,
    StartDoctypeTag = 15,
    Doctype = 16,
    EndDoctypeTag = 17,
    Content = 18,
    InterpolationContent = 19,
    Whitespace = 20,
    Unknown = 21,
    Script = 22,
    Styles = 23,
    EOS = 24
}
declare enum ScannerState {
    WithinContent = 0,
    WithinInterpolation = 1,
    AfterOpeningStartTag = 2,
    AfterOpeningEndTag = 3,
    WithinDoctype = 4,
    WithinTag = 5,
    WithinEndTag = 6,
    WithinComment = 7,
    WithinScriptContent = 8,
    WithinStyleContent = 9,
    AfterAttributeName = 10,
    BeforeAttributeValue = 11
}
interface Scanner {
    scan(): HtmlTokenType;
    scanForRegexp(regexp: RegExp): HtmlTokenType;
    getTokenType(): HtmlTokenType;
    getTokenOffset(): number;
    getTokenLength(): number;
    getTokenEnd(): number;
    getTokenText(): string;
    getTokenError(): string;
    getScannerState(): ScannerState;
}
declare function createScanner(input: string, initialOffset?: number, initialState?: ScannerState): Scanner;

interface TagCollector {
    (tag: string, documentation: string | MarkupContent$1): void;
}
interface Attribute {
    label: string;
    type?: string;
    documentation?: string | MarkupContent$1;
}
interface AttributeCollector {
    (attribute: string, type?: string, documentation?: string | MarkupContent$1): void;
}
interface StandaloneAttribute {
    label: string;
    type?: string;
    documentation?: string | MarkupContent$1;
}
declare enum TagProviderPriority {
    UserCode = 0,
    Library = 1,
    Framework = 2,
    Platform = 3
}
interface IHTMLTagProvider {
    getId(): string;
    collectTags(collector: TagCollector): void;
    collectAttributes(tag: string, collector: AttributeCollector): void;
    collectValues(tag: string, attribute: string, collector: (value: string) => void): void;
    readonly priority: TagProviderPriority;
}
interface ITagSet {
    [tag: string]: HTMLTagSpecification;
}
declare class HTMLTagSpecification {
    documentation: string | MarkupContent$1;
    attributes: Attribute[];
    constructor(documentation: string | MarkupContent$1, attributes?: Attribute[]);
}
interface IValueSets {
    [tag: string]: string[];
}
declare function getSameTagInSet<T>(tagSet: Record<string, T>, tag: string): T | undefined;
declare function collectTagsDefault(collector: TagCollector, tagSet: ITagSet): void;
declare function collectAttributesDefault(tag: string, collector: AttributeCollector, tagSet: ITagSet, globalAttributes: StandaloneAttribute[]): void;
declare function collectValuesDefault(tag: string, attribute: string, collector: (value: string) => void, tagSet: ITagSet, globalAttributes: StandaloneAttribute[], valueSets: IValueSets): void;
declare function genAttribute(label: string, type?: string, documentation?: string | MarkupContent$1): Attribute;

declare function doComplete(document: TextDocument, position: Position, htmlDocument: HTMLDocument, tagProviders: IHTMLTagProvider[], emmetConfig: emmet.VSCodeEmmetConfig, autoImportCompletions?: CompletionItem[]): CompletionList;
declare function normalizeAttributeNameToKebabCase(attr: string): string;

declare function findDefinition(document: TextDocument, position: Position, htmlDocument: HTMLDocument, vueFileInfo?: VueFileInfo): Location[];

declare function doESLintValidation(document: TextDocument, engine: ESLint): Promise<Diagnostic[]>;
declare function createLintEngine(vueVersion: VueVersion): ESLint;

declare function getFoldingRanges(document: TextDocument): FoldingRange[];

declare function htmlFormat(dependencyService: DependencyService, document: TextDocument, currRange: Range, vlsFormatConfig: VLSFormatConfig): TextEdit[];

declare function findDocumentHighlights(document: TextDocument, position: Position, htmlDocument: HTMLDocument): DocumentHighlight[];

declare function doHover(document: TextDocument, position: Position, htmlDocument: HTMLDocument, tagProviders: IHTMLTagProvider[]): Hover;

declare function findDocumentLinks(document: TextDocument, documentContext: DocumentContext): DocumentLink[];

declare function findDocumentSymbols(document: TextDocument, htmlDocument: HTMLDocument): SymbolInformation[];

declare function isInsideInterpolation(node: Node, nodeText: string, relativePos: number): boolean;

declare function doPropValidation(document: TextDocument, htmlDocument: HTMLDocument, info: VueFileInfo, vueVersion: VueVersion): Diagnostic[];

declare function getComponentInfoTagProvider(childComponents: ChildComponent[]): IHTMLTagProvider;

declare const elementTagProvider: IHTMLTagProvider;
declare const onsenTagProvider: IHTMLTagProvider;
declare const bootstrapTagProvider: IHTMLTagProvider;
declare const gridsomeTagProvider: IHTMLTagProvider;
/**
 * Get tag providers specified in workspace root's packaage.json
 */
declare function getWorkspaceTagProvider(packageRoot: string, rootPkgJson: any): IHTMLTagProvider | null;
/**
 * Get tag providers specified in packaage.json's `vetur` key
 */
declare function getDependencyTagProvider(packageRoot: string, depName: string, depPkgJson: any): IHTMLTagProvider | null;
declare function getExternalTagProvider(id: string, tags: any, attributes: any): IHTMLTagProvider;

/*!
BEGIN THIRD PARTY
*/

declare const VOID_ELEMENTS: string[];
declare function isVoidElement(e: string | undefined): boolean;
declare const HTML_TAGS: ITagSet;
declare function getHTML5TagProvider(): IHTMLTagProvider;

declare let allTagProviders: IHTMLTagProvider[];
interface CompletionConfiguration {
    [provider: string]: boolean;
}
declare function getTagProviderSettings(packagePath: string | undefined): CompletionConfiguration;
declare function getEnabledTagProviders(tagProviderSetting: CompletionConfiguration): IHTMLTagProvider[];

declare function getNuxtTagProvider(packageRoot: string): IHTMLTagProvider;

declare function getRouterTagProvider(): IHTMLTagProvider;

declare function getVueTagProvider(): IHTMLTagProvider;

export { Attribute, AttributeCollector, AutoImportSfcPlugin, BaseCodeActionData, BasicComponentInfo, ChildComponent, CodeActionData, CodeActionDataKind, CombinedFixActionData, CompletionAsserter, CompletionConfiguration, CompletionTestSetup, ComponentInfo, ComputedInfo, DataInfo, DependencyService, DocumentContext, DocumentService, EmbeddedRegion, EmitInfo, EnvironmentService, Glob, HTMLDocument, HTMLMode, HTMLTagSpecification, HTML_TAGS, HoverAsserter, HoverTestSetup, HtmlTokenType, IHTMLTagProvider, IServiceHost, IStylusSupremacy, ITagSet, IValueSets, InternalChildComponent, LanguageId, LanguageMode, LanguageModeRange, LanguageModelCache, LanguageModes, LanguageRange, LoadedCSSData, MethodInfo, Modifier, ModuleResolutionCache, NULL_COMPLETION, NULL_HOVER, NULL_SIGNATURE, Node, OrganizeImportsActionData, ProjectService, PropInfo, RefTokensService, RefactorActionData, RegionType$1 as RegionType, RuntimeLibrary, SassLanguageMode, ScaffoldSnippetSources, Scanner, ScannerState, SemanticTokenData, SemanticTokenOffsetData, SnippetManager, StylePriority, StylusNode, TSCodeActionKind, TagProviderPriority, TemplateSourceMap, TemplateSourceMapNode, TokenModifier, TsTokenType, VCancellationToken, VCancellationTokenSource, VLS, VLSConfig, VLSFormatConfig, VLSFullConfig, VLSServices, VOID_ELEMENTS, VeturConfig, VeturFullConfig, VeturProject, VueDocumentRegions, VueFileInfo, VueHTMLMode, VueInfoService, VueInterpolationMode, VueVersion, addCompositionApiRefTokens, allTagProviders, analyzeComponentsDefine, analyzeDefaultExportExpr, bootstrapTagProvider, buildAst, buildDocumentation, builtIn, collectAttributesDefault, collectTagsDefault, collectValuesDefault, componentDataName, componentHelperName, createAutoImportSfcPlugin, createDependencyService, createEnvironmentService, createLintEngine, createNodeModulesPaths, createProjectService, createRefTokensService, createScanner, createTemplateDiagnosticFilter, createUpdater, cssColors, cssData, doComplete, doESLintValidation, doHover, doPropValidation, elementTagProvider, fileName, findConfigFile, findDefinition, findDocumentHighlights, findDocumentLinks, findDocumentSymbols, findNodeAtPosition, findNodeByOffset, findPropertySchema, findTokenAtPosition, flattenAndFilterAst, genAttribute, generateSourceMap, getAllSymbols, getAtRules, getCSSMode, getClassDecoratorArgumentType, getCodeActionKind, getComponentInfo, getComponentInfoTagProvider, getDefaultExportNode, getDefaultVLSConfig, getDependencyTagProvider, getEnabledTagProviders, getExternalTagProvider, getFileFsPath, getFilePath, getFoldingRanges, getFormatCodeSettings, getFsPathToUri, getGlobalComponents, getHTML5TagProvider, getJavascriptMode, getLESSMode, getLanguageModelCache, getLanguageRangesOfType, getLastChild, getModifierProvider, getNuxtTagProvider, getPathDepth, getPostCSSMode, getProperties, getPropertyName, getPugMode, getRouterTagProvider, getSCSSMode, getSameTagInSet, getSemanticTokenLegends, getServiceHost, getSingleLanguageDocument, getSingleTypeDocument, getStylusMode, getTagDefinition, getTagDocumentation, getTagProviderSettings, getTemplateTransformFunctions, getTokenModifierFromClassification, getTokenTypeFromClassification, getValues, getVeturFullConfig, getVueDocumentRegions, getVueMode, getVueSys, getVueTagProvider, getVueVersionKey, getWordAtText, getWorkspaceTagProvider, globalScope, gridsomeTagProvider, hoverDSL, htmlFormat, indentSection, inferVueVersion, injectVueTemplate, isAtRule, isAtRuleNode, isClassOrId, isClassType, isColor, isFunctionNode, isInsideInterpolation, isSelectorCallNode, isSelectorNode, isVCancellationRequested, isValue, isVariableNode, isVirtualVueFile, isVirtualVueTemplateFile, isVoidElement, isVueFile, iterationHelperName, languageServiceIncludesFile, locToRange, logger, mapBackRange, mapFromPositionToOffset, mapToRange, moduleName, modulePathToValidIdentifier, normalizeAbsolutePath, normalizeAttributeNameToKebabCase, normalizeFileNameResolve, normalizeFileNameToFsPath, nullMode, onsenTagProvider, parse, parseHTMLDocument, parseVueDocumentRegions, parseVueScript, parseVueTemplate, plain, preVue25Content, prettierEslintify, prettierPluginPugify, prettierTslintify, prettierify, printSourceMap, provideCompletionItems, provideDocumentSymbols, removeQuotes, renderHelperName, requireUncached, sleep, stringifySourceMapNodes, stylusHover, templateSourceMap, testDSL, toCompletionItemKind, toMarkupContent, toSymbolKind, vue25Content, vue30Content, walkExpression, wordPattern };
