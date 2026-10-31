describe("make conservative indentation", () => {
  let editor;
  beforeEach(async () => {
    jasmine.useRealClock();
    await lumine.packages.activatePackage("language-make");
    editor = await lumine.workspace.open("Makefile");
    editor.update({ autoIndent: true, tabLength: 2, softTabs: false });
  });
  afterEach(() => editor.destroy());
  async function newline(source) {
    editor.setText(source);
    await editor.whenGrammarSettled();
    editor.setCursorBufferPosition([0, Infinity]);
    await editor.insertNewline();
    return editor.lineTextForBufferRow(1);
  }
  it("does not guess indentation from an unfinished construct", async () => {
    expect(await newline("target:")).toBe("");
  });
  it("inherits manual indentation when continuing a line", async () => {
    expect(await newline("\techo value")).toBe("\t");
  });
  it("ignores structural-looking punctuation in comments", async () => {
    expect(await newline("# ifdef ( {")).toBe("");
  });
});
