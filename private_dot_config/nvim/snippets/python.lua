local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Python comments

  s({ trig = "cml", name = "Long comment", dscr = "Insert a multi-line comment block" }, {
    t({ '"""', "" }),
    i(0),
    t({ "", '"""' }),
  }),

  s({ trig = "cmld", name = "Docstring", dscr = "Insert a docstring comment" }, {
    t({ '"""', "" }),
    i(1, "Description"),
    t({ "", "", "Args:" }),
    t({ "", "    " }),
    i(2, "param_name"),
    t(": "),
    i(3, "param_description"),
    t({ "", "", "Returns:", "    " }),
    i(4, "return_description"),
    t({ "", '"""' }),
    i(0),
  }),

  -- 边框和分隔符 (Python style)
  s({ trig = "box", name = "Comment box", dscr = "Create a Python-style comment box" }, {
    t({ "##############################################################################", "# " }),
    i(0),
    t({ "", "##############################################################################" }),
  }),

  -- Context managers
  s(
    { trig = "withopen", name = "With open file", dscr = "File open context manager" },
    { t("with open("), i(1, "filename"), t(", "), i(2, '"r"'), t(") as "), i(3, "f"), t({ ":", "\t" }), i(0) }
  ),

  s({
    trig = "contextlib",
    name = "Context manager using contextlib",
    dscr = "Create a context manager using contextlib.contextmanager",
  }, {
    t({ "from contextlib import contextmanager", "", "", "@contextmanager", "def " }),
    i(1, "my_context_manager"),
    t("("),
    i(2),
    t({ "):", "\t" }),
    t({ "try:", "\t\t" }),
    i(3, "yield"),
    t({ "", "\tfinally:", "\t\t" }),
    i(0, "pass"),
  }),

  -- Async/Await
  s(
    { trig = "async", name = "Async function", dscr = "Define an async function" },
    { t("async def "), i(1, "function_name"), t("("), i(2), t(") -> "), i(3, "None"), t({ ":", "\t" }), i(0) }
  ),

  s(
    { trig = "await", name = "Await expression", dscr = "Await an asynchronous function call" },
    { t("await "), i(1, "coroutine"), t("("), i(2), t(")"), i(0) }
  ),

  s(
    { trig = "asyncfor", name = "Async for loop", dscr = "Define an async for loop" },
    { t("async for "), i(1, "item"), t(" in "), i(2, "async_iterator"), t({ ":", "\t" }), i(0) }
  ),

  s(
    { trig = "asyncwith", name = "Async with statement", dscr = "Define an async with statement" },
    { t("async with "), i(1, "async_context"), t(" as "), i(2, "var"), t({ ":", "\t" }), i(0) }
  ),

  -- Type hints
  s({ trig = "typeddict", name = "TypedDict", dscr = "Define a TypedDict class" }, {
    t({ "from typing import TypedDict", "", "", "class " }),
    i(1, "MyDict"),
    t({ "(TypedDict):", "\t" }),
    i(2, "field1"),
    t(": "),
    i(3, "str"),
    t({ "", "\t" }),
    i(0),
  }),

  s(
    { trig = "annot", name = "Type annotation", dscr = "Add type annotation to a variable" },
    { i(1, "variable"), t(": "), i(2, "Type"), t(" = "), i(3), i(0) }
  ),

  s(
    { trig = "typealias", name = "Type alias", dscr = "Create a type alias" },
    { i(1, "Alias"), t(" = "), i(2, "List[str]"), i(0) }
  ),

  s({ trig = "protocol", name = "Protocol class", dscr = "Define a Protocol class" }, {
    t({ "from typing import Protocol", "", "", "class " }),
    i(1, "MyProtocol"),
    t({ "(Protocol):", "\t" }),
    t("def "),
    i(2, "method"),
    t("(self"),
    i(3),
    t({ ") -> " }),
    i(4, "None"),
    t({ ":", "\t\t..." }),
    t({ "", "\t" }),
    i(0),
  }),

  s({ trig = "union", name = "Union type", dscr = "Create a Union type annotation" }, {
    i(1, "variable"),
    t(": "),
    c(2, {
      t("Union["),
      t(""),
    }),
    i(3, "str"),
    t(", "),
    i(4, "None"),
    t("]"),
    i(0),
  }),

  -- Dataclasses
  s({ trig = "dataclass", name = "Data class", dscr = "Define a dataclass" }, {
    t({ "from dataclasses import dataclass", "", "", "@dataclass", "class " }),
    i(1, "MyClass"),
    t({ ":", "\t" }),
    i(2, "field1"),
    t(": "),
    i(3, "str"),
    t({ "", "\t" }),
    i(0),
  }),

  s({ trig = "field", name = "Dataclass field", dscr = "Define a dataclass field with options" }, {
    t("field("),
    i(1),
    c(2, {
      t(", default="),
      t(", default_factory="),
      t(""),
    }),
    i(3),
    c(4, {
      t(", repr=False"),
      t(", compare=False"),
      t(""),
    }),
    i(0),
    t(")"),
  }),

  -- Named tuples
  s({ trig = "namedtuple", name = "Named tuple", dscr = "Define a named tuple" }, {
    t({ "from collections import namedtuple", "", "", "" }),
    i(1, "Point"),
    t(" = namedtuple('"),
    rep(1),
    t("', ["),
    i(2, "'x', 'y'"),
    t("])"),
  }),

  s({ trig = "typednamedtuple", name = "Typed named tuple", dscr = "Define a typed named tuple" }, {
    t({ "from typing import NamedTuple", "", "", "class " }),
    i(1, "Point"),
    t({ "(NamedTuple):", "\t" }),
    i(2, "x"),
    t(": "),
    i(3, "float"),
    t({ "", "\t" }),
    i(4, "y"),
    t(": "),
    i(5, "float"),
    t({ "", "\t" }),
    i(0),
  }),

  -- Enum
  s({ trig = "enum", name = "Enum class", dscr = "Define an enum class" }, {
    t({ "from enum import Enum", "", "", "class " }),
    i(1, "Color"),
    t({ "(Enum):", "\t" }),
    i(2, "RED"),
    t(" = "),
    i(3, "1"),
    t({ "", "\t" }),
    i(4, "GREEN"),
    t(" = "),
    i(5, "2"),
    t({ "", "\t" }),
    i(0),
  }),

  -- Abstract Base Class
  s({ trig = "abstractmethod", name = "Abstract method", dscr = "Define an abstract method" }, {
    t("@abstractmethod"),
    t({ "", "def " }),
    i(1, "method_name"),
    t("(self"),
    i(2),
    t({ ") -> " }),
    i(3, "None"),
    t({ ":", "\t" }),
    i(0, "pass"),
  }),

  s({ trig = "abstractclass", name = "Abstract class", dscr = "Define an abstract base class" }, {
    t({ "from abc import ABC, abstractmethod", "", "", "class " }),
    i(1, "MyAbstractClass"),
    t({ "(ABC):", "\t" }),
    t({ "@abstractmethod", "\tdef " }),
    i(2, "abstract_method"),
    t("(self"),
    i(3),
    t({ ") -> " }),
    i(4, "None"),
    t({ ":", "\t\t" }),
    i(0, "pass"),
  }),

  -- Exception handling
  s({ trig = "tryctx", name = "Try with context manager", dscr = "Try block with a context manager" }, {
    t({ "try:", "\twith " }),
    i(1, "context"),
    t(" as "),
    i(2, "var"),
    t({ ":", "\t\t" }),
    i(3),
    t({ "", "except " }),
    i(4, "Exception"),
    t(" as "),
    i(5, "e"),
    t({ ":", "\t" }),
    i(0, "pass"),
  }),

  -- Common Python patterns
  s({ trig = "argparse", name = "Argument parser", dscr = "Create an argparse-based CLI" }, {
    t({
      "import argparse",
      "",
      "def parse_args():",
      "\tparser = argparse.ArgumentParser(description='",
    }),
    i(1, "Script description"),
    t({ "')", "\tparser.add_argument('" }),
    i(2, "arg1"),
    t({ "', help='" }),
    i(3, "help for arg1"),
    t({
      "')",
      "\treturn parser.parse_args()",
      "",
      "def main():",
      "\targs = parse_args()",
      "\t",
    }),
    i(0),
    t({
      "",
      'if __name__ == "__main__":',
      "\tmain()",
    }),
  }),

  s({ trig = "logging", name = "Setup logging", dscr = "Setup Python logging" }, {
    t({
      "import logging",
      "",
      "# Configure logging",
      "logging.basicConfig(",
      "\tlevel=logging.",
    }),
    c(1, { t("INFO"), t("DEBUG"), t("WARNING"), t("ERROR"), t("CRITICAL") }),
    t({
      ",",
      "\tformat='%(asctime)s - %(name)s - %(levelname)s - %(message)s')",
      "",
      "logger = logging.getLogger(",
    }),
    i(2, "__name__"),
    t({ ")" }),
    t({
      "",
      "",
      "# Usage",
      "logger.debug('Debug message')",
      "logger.info('Info message')",
      "logger.warning('Warning message')",
      "logger.error('Error message')",
      "logger.critical('Critical message')",
    }),
    t({ "", "" }),
    i(0),
  }),

  s({ trig = "sqlalchemy", name = "SQLAlchemy model", dscr = "Create a SQLAlchemy model" }, {
    t({
      "from sqlalchemy import Column, Integer, String, ForeignKey",
      "from sqlalchemy.ext.declarative import declarative_base",
      "",
      "Base = declarative_base()",
      "",
      "class ",
    }),
    i(1, "ModelName"),
    t({ "(Base):", '\t__tablename__ = "' }),
    i(2, "tablename"),
    t({ '"', "", "\tid = Column(Integer, primary_key=True)", "\t" }),
    i(3, "name"),
    t({ " = Column(String" }),
    i(4, "(50)"),
    t({ ")" }),
    t({ "", "\t" }),
    i(0),
  }),

  s({ trig = "fastapi", name = "FastAPI endpoint", dscr = "Create a FastAPI endpoint" }, {
    t({
      "from fastapi import FastAPI, HTTPException, Depends",
      "from pydantic import BaseModel",
      "",
      "app = FastAPI()",
      "",
      "class ",
    }),
    i(1, "Item"),
    t({ "(BaseModel):", "\t" }),
    i(2, "name"),
    t({ ": str", "\t" }),
    i(3, "description"),
    t({ ": str = None", "", "@app." }),
    c(4, { t("get"), t("post"), t("put"), t("delete") }),
    t({ "('/" }),
    i(5, "items"),
    t({ "')", "async def " }),
    i(6, "function_name"),
    t({ "(" }),
    i(7),
    t({ ") -> " }),
    i(8, "dict"),
    t({ ":", "\t" }),
    i(0, "pass"),
  }),

  -- Testing helpers
  s({ trig = "pytest", name = "Pytest fixture", dscr = "Create a pytest fixture" }, {
    t({
      "import pytest",
      "",
      "@pytest.fixture",
      "def ",
    }),
    i(1, "fixture_name"),
    t({ "(" }),
    i(2),
    t({ "):", "\t" }),
    i(3, "# Setup code"),
    t({ "", "\tyield " }),
    i(4, "value"),
    t({ "", "\t" }),
    i(0, "# Teardown code"),
  }),

  s({ trig = "testcase", name = "Test case", dscr = "Create a test case function" }, {
    t({ "def test_" }),
    i(1, "function_name"),
    t({ "(" }),
    i(2),
    t({ "):", "\t# Arrange", "\t" }),
    i(3),
    t({ "", "\t# Act", "\t" }),
    i(4),
    t({ "", "\t# Assert", "\t" }),
    i(0),
  }),

  s({ trig = "mock", name = "Mock object", dscr = "Create a mock object" }, {
    t({ "from unittest.mock import Mock, patch", "", "" }),
    c(1, {
      t("mock_obj = Mock()"),
      t("@patch('"),
      t("with patch('"),
    }),
    i(2),
    c(3, {
      t(""),
      t("')\ndef test_"),
      t("') as mock_obj:"),
    }),
    i(0),
  }),

  -- Web development
  s({ trig = "flask", name = "Flask route", dscr = "Create a Flask route" }, {
    t({
      "from flask import Flask, request, jsonify",
      "",
      "app = Flask(__name__)",
      "",
      "@app.route('/",
    }),
    i(1, "endpoint"),
    t({ "', methods=[" }),
    c(2, { t("'GET'"), t("'POST'"), t("'PUT'"), t("'DELETE'") }),
    t({ "])", "def " }),
    i(3, "function_name"),
    t({ "():", "\t" }),
    i(0),
  }),

  -- Common data structures
  s({ trig = "defaultdict", name = "Default dict", dscr = "Create a defaultdict" }, {
    t({ "from collections import defaultdict", "", "" }),
    i(1, "data"),
    t(" = defaultdict("),
    i(2, "list"),
    t(")"),
    i(0),
  }),

  s({ trig = "counter", name = "Counter", dscr = "Create a Counter" }, {
    t({ "from collections import Counter", "", "" }),
    i(1, "counter"),
    t(" = Counter("),
    i(2),
    t(")"),
    i(0),
  }),

  s({ trig = "deque", name = "Deque", dscr = "Create a deque" }, {
    t({ "from collections import deque", "", "" }),
    i(1, "queue"),
    t(" = deque("),
    i(2),
    t({ ")", "" }),
    i(0),
  }),

  -- File operations
  s({ trig = "readlines", name = "Read file lines", dscr = "Read all lines from a file" }, {
    t({ "with open(" }),
    i(1, "filename"),
    t({ ", 'r') as f:", "\tlines = f.readlines()", "\t" }),
    i(0),
  }),

  s({ trig = "writelines", name = "Write file lines", dscr = "Write lines to a file" }, {
    t({ "with open(" }),
    i(1, "filename"),
    t({ ", 'w') as f:", "\tf.writelines([" }),
    i(2),
    t({ "])", "\t" }),
    i(0),
  }),

  s({ trig = "jsonload", name = "Load JSON", dscr = "Load data from a JSON file" }, {
    t({ "import json", "", "with open(" }),
    i(1, "filename"),
    t({ ", 'r') as f:", "\tdata = json.load(f)", "\t" }),
    i(0),
  }),

  s({ trig = "jsondump", name = "Dump JSON", dscr = "Write data to a JSON file" }, {
    t({ "import json", "", "with open(" }),
    i(1, "filename"),
    t({ ", 'w') as f:", "\tjson.dump(" }),
    i(2, "data"),
    t({ ", f, indent=4)", "\t" }),
    i(0),
  }),

  -- Path operations with pathlib
  s({ trig = "pathlib", name = "Pathlib usage", dscr = "Common pathlib operations" }, {
    t({ "from pathlib import Path", "", "" }),
    i(1, "path"),
    t(" = Path("),
    i(2, '"."'),
    t({ ")" }),
    c(3, {
      t(""),
      t(".joinpath("),
      t(".glob('"),
      t(".is_file()"),
      t(".is_dir()"),
      t(".exists()"),
    }),
    i(0),
  }),

  -- Functional programming
  s({ trig = "filterl", name = "Filter with lambda", dscr = "Filter a sequence using a lambda" }, {
    i(1, "result"),
    t(" = filter(lambda "),
    i(2, "x"),
    t(": "),
    i(3),
    t(", "),
    i(4, "sequence"),
    t(")"),
    i(0),
  }),

  s({ trig = "mapl", name = "Map with lambda", dscr = "Map a function over a sequence using a lambda" }, {
    i(1, "result"),
    t(" = map(lambda "),
    i(2, "x"),
    t(": "),
    i(3),
    t(", "),
    i(4, "sequence"),
    t(")"),
    i(0),
  }),

  -- Decorators
  s({ trig = "deco", name = "Decorator", dscr = "Create a decorator" }, {
    t({ "def " }),
    i(1, "decorator_name"),
    t({ "(func):", "\tdef wrapper(*args, **kwargs):", "\t\t" }),
    i(2, "# Before function call"),
    t({ "", "\t\tresult = func(*args, **kwargs)", "\t\t" }),
    i(3, "# After function call"),
    t({ "", "\t\treturn result", "\treturn wrapper" }),
    i(0),
  }),

  s({ trig = "decoarg", name = "Decorator with arguments", dscr = "Create a decorator with arguments" }, {
    t({ "def " }),
    i(1, "decorator_name"),
    t({ "(" }),
    i(2, "decorator_arg"),
    t({
      "):",
      "\tdef actual_decorator(func):",
      "\t\tdef wrapper(*args, **kwargs):",
      "\t\t\t# Access to ",
    }),
    rep(2),
    t({
      " here",
      "\t\t\tresult = func(*args, **kwargs)",
      "\t\t\treturn result",
      "\t\treturn wrapper",
      "\treturn actual_decorator",
    }),
    i(0),
  }),

  -- Type checking and runtime type assertions
  s({ trig = "typeguard", name = "Type guard", dscr = "Create a type guard function" }, {
    t({ "def is_" }),
    i(1, "type_name"),
    t({ "(obj: object) -> bool:", "\treturn isinstance(obj, " }),
    i(2, "type"),
    t({ ")" }),
    i(0),
  }),

  -- Concurrency and parallelism
  s({ trig = "threadpool", name = "ThreadPoolExecutor", dscr = "Use ThreadPoolExecutor for concurrent tasks" }, {
    t({ "from concurrent.futures import ThreadPoolExecutor", "", "with ThreadPoolExecutor(max_workers=" }),
    i(1, "4"),
    t({ ") as executor:", "\tfutures = [executor.submit(" }),
    i(2, "func"),
    t({ ", " }),
    i(3, "arg"),
    t({ ") for " }),
    rep(3),
    t({ " in " }),
    i(4, "items"),
    t({ "]", "\tfor future in futures:", "\t\tresult = future.result()", "\t\t" }),
    i(0),
  }),

  s({ trig = "processpool", name = "ProcessPoolExecutor", dscr = "Use ProcessPoolExecutor for parallel tasks" }, {
    t({ "from concurrent.futures import ProcessPoolExecutor", "", "with ProcessPoolExecutor(max_workers=" }),
    i(1, "4"),
    t({ ") as executor:", "\tresults = list(executor.map(" }),
    i(2, "func"),
    t({ ", " }),
    i(3, "items"),
    t({ "))", "\t" }),
    i(0),
  }),

  -- More advanced snippets
  s({ trig = "singleton", name = "Singleton class", dscr = "Define a singleton class" }, {
    t({ "class " }),
    i(1, "Singleton"),
    t({
      "(type):",
      "\t_instances = {}",
      "\tdef __call__(cls, *args, **kwargs):",
      "\t\tif cls not in cls._instances:",
      "\t\t\tcls._instances[cls] = super(",
    }),
    rep(1),
    t({ ", cls).__call__(*args, **kwargs)", "\t\treturn cls._instances[cls]", "", "class " }),
    i(2, "MyClass"),
    t({ "(metaclass=" }),
    rep(1),
    t({ "):", "\tdef __init__(self):", "\t\tpass", "\t" }),
    i(0),
  }),

  -- CLI helpers
  s({ trig = "click", name = "Click command", dscr = "Create a Click command" }, {
    t({ "import click", "", "@click.command()", "@click.option('--" }),
    i(1, "option"),
    t({ "', help='" }),
    i(2, "Help text"),
    t({ "')", "@click.argument('" }),
    i(3, "argument"),
    t({ "')", "def " }),
    i(4, "command"),
    t({ "(" }),
    rep(1),
    t({ ", " }),
    rep(3),
    t({ "):", '\t"""' }),
    i(5, "Command description"),
    t({ '"""', "\t" }),
    i(0),
    t({ "", "", "if __name__ == '__main__':", "\t" }),
    rep(4),
    t({ "()" }),
  }),

  -- f-strings
  s(
    { trig = "fe", name = "Format expression", dscr = "Create an f-string with expression" },
    { t('f"'), i(1), t("{"), i(2), t("}"), i(3), t('"'), i(0) }
  ),

  s(
    { trig = "fd", name = "Format debug", dscr = "Create a debug f-string" },
    { t('f"'), i(1, "var"), t("={"), rep(1), t('}"'), i(0) }
  ),

  -- Regular expressions
  s({ trig = "recomp", name = "Compiled regex", dscr = "Create a compiled regular expression" }, {
    t({ "import re", "", "pattern = re.compile(r'" }),
    i(1, "regex"),
    t({ "')" }),
    i(0),
  }),

  s({ trig = "fgb", name = "Find all", dscr = "Find all occurrences of a pattern" }, {
    i(1, "matches"),
    t(" = re.findall(r'"),
    i(2, "pattern"),
    t("', "),
    i(3, "string"),
    t(")"),
    i(0),
  }),
}
