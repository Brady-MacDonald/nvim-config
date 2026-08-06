local luasnip = require("luasnip")
local s = luasnip.snippet
local tNode = luasnip.text_node
local iNode = luasnip.insert_node
local fNode = luasnip.function_node

-- Helper function to get filename without extension
local function get_class_name()
    return vim.fn.expand("%:t:r")
end

luasnip.add_snippets("cs", {
    -- Class template
    s("class", {
        tNode("public class "),
        fNode(get_class_name),
        tNode({ "", "{", "    " }),
        iNode(1, "// Constructor or members"),
        tNode({ "", "}" }),
    }),

    -- Interface template
    s("interface", {
        tNode("public interface I"),
        fNode(get_class_name),
        tNode({ "", "{", "    " }),
        iNode(1, "// Interface members"),
        tNode({ "", "}" }),
    }),

    -- Constructor
    s("ctor", {
        tNode("public "),
        fNode(get_class_name),
        tNode("("),
        iNode(1, ""),
        tNode({ ")", "{", "    " }),
        iNode(2, ""),
        tNode({ "", "}" }),
    }),

    -- Method template
    s("method", {
        tNode("public "),
        iNode(1, "void"),
        tNode(" "),
        iNode(2, "MethodName"),
        tNode("("),
        iNode(3, ""),
        tNode({ ")", "{", "    " }),
        iNode(4, ""),
        tNode({ "", "}" }),
    }),

    -- Async method
    s("async", {
        tNode("public async Task"),
        iNode(1, ""),
        tNode(" "),
        iNode(2, "MethodName"),
        tNode("("),
        iNode(3, ""),
        tNode({ ")", "{", "    " }),
        iNode(4, "await "),
        tNode({ "", "}" }),
    }),

    -- Property with getter/setter
    s("prop", {
        tNode("public "),
        iNode(1, "string"),
        tNode(" "),
        iNode(2, "PropertyName"),
        tNode(" { get; set; }"),
    }),

    -- Property with private setter
    s("propg", {
        tNode("public "),
        iNode(1, "string"),
        tNode(" "),
        iNode(2, "PropertyName"),
        tNode(" { get; private set; }"),
    }),

    -- Auto property with init
    s("propi", {
        tNode("public "),
        iNode(1, "string"),
        tNode(" "),
        iNode(2, "PropertyName"),
        tNode(" { get; init; }"),
    }),

    -- Test method (xUnit)
    s("test", {
        tNode({ "[Fact]", "public void " }),
        iNode(1, "TestMethodName"),
        tNode({ "()", "{", "    // Arrange", "    " }),
        iNode(2, ""),
        tNode({ "", "    ", "    // Act", "    " }),
        iNode(3, ""),
        tNode({ "", "    ", "    // Assert", "    " }),
        iNode(4, ""),
        tNode({ "", "}" }),
    }),

    -- Test method with theory (xUnit)
    s("theory", {
        tNode({ "[Theory]", "[InlineData(" }),
        iNode(1, ""),
        tNode({ ")]", "public void " }),
        iNode(2, "TestMethodName"),
        tNode("("),
        iNode(3, ""),
        tNode({ ")", "{", "    // Arrange", "    " }),
        iNode(4, ""),
        tNode({ "", "    ", "    // Act", "    " }),
        iNode(5, ""),
        tNode({ "", "    ", "    // Assert", "    " }),
        iNode(6, ""),
        tNode({ "", "}" }),
    }),

    -- Try-catch
    s("try", {
        tNode({ "try", "{", "    " }),
        iNode(1, ""),
        tNode({ "", "}", "catch (" }),
        iNode(2, "Exception ex"),
        tNode({ ")", "{", "    " }),
        iNode(3, "// Handle exception"),
        tNode({ "", "}" }),
    }),

    -- Using statement
    s("using", {
        tNode("using ("),
        iNode(1, "var "),
        tNode({ ")", "{", "    " }),
        iNode(2, ""),
        tNode({ "", "}" }),
    }),

    -- Null check with throw
    s("null", {
        iNode(1, "parameter"),
        tNode(" ?? throw new ArgumentNullException(nameof("),
        iNode(2, "parameter"),
        tNode("));"),
    }),

    -- Logger injection
    s("logger", {
        tNode("private readonly ILogger<"),
        fNode(get_class_name),
        tNode("> _logger;"),
    }),

    -- Dependency injection constructor
    s("dictor", {
        tNode("public "),
        fNode(get_class_name),
        tNode("("),
        iNode(1, "IDependency dependency"),
        tNode({ ")", "{", "    _" }),
        iNode(2, "dependency"),
        tNode(" = "),
        iNode(3, "dependency"),
        tNode(" ?? throw new ArgumentNullException(nameof("),
        iNode(4, "dependency"),
        tNode({ "));", "}" }),
    }),

    -- LINQ query
    s("linq", {
        tNode("var "),
        iNode(1, "result"),
        tNode(" = "),
        iNode(2, "collection"),
        tNode({ "", "    .Where(" }),
        iNode(3, "x => x.Condition"),
        tNode({ ")", "    .Select(" }),
        iNode(4, "x => x.Property"),
        tNode({ ")", "    .ToList();" }),
    }),

    -- Record type
    s("record", {
        tNode("public record "),
        fNode(get_class_name),
        tNode("("),
        iNode(1, ""),
        tNode(");"),
    }),
})
