
--[[
  GUÍA RÁPIDA DE LUASNIP:
  s("disparador", { nodos }) -> Define el snippet.
  t("texto")                -> Texto fijo.
  t({"línea 1", "línea 2"}) -> Texto multilínea.
  i(1, "placeholder")       -> Punto de inserción (salto con Ctrl+K).
  i(0)                      -> Punto final donde termina el cursor.
  f(función, {nodos})       -> Nodo dinámico (transforma texto de otros nodos).
]]

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node -- Importamos el nodo de función

--[[
  TRANSFORMACIONES DINÁMICAS:
  La función 'snake_case' usa 'gsub' de Lua. 
  'gsub' busca patrones (en este caso el espacio " ") 
  y los reemplaza por el segundo argumento (el guion bajo "_").
  Esto es útil para que si en Go escribes 'UserName', 
  en el tag de la DB se escriba 'user_name'.
]]

 local function snake_case(args)
    local text = args[1][1] or ""
    -- Pasamos a minúsculas
    text = string.lower(text)
    -- Reemplazamos espacios por guiones bajos
    text = string.gsub(text, " ", "_")
    return text
  end

ls.add_snippets("handlebars", {
  -- Snippet para la estructura base: Escribe 'hbs!!' y presiona Tab
  s("hbs!!", {
    t({ "<!DOCTYPE html>", '<html lang="es">', "<head>", "  <meta charset='UTF-8'>", "  <title>" }),
    i(1, "Documento"),
    t({ "</title>", "</head>", "<body>", "  " }),
    i(0),
    t({ "", "</body>", "</html>" }),
  }),

  s("hif", { -- "hif" es lo que escribes para activar
    t("{{#if "), i(1, "condicion"), t("}}"), -- El cursor empieza en 'condicion'
    t({"", "  "}), i(0),  -- Al saltar, va al centro (el 0 es el final)
    t({"", "{{/if}}"}),            -- Texto de cierre
  }),

  -- Snippet para un Each: Escribe 'heach' y presiona Tab
  s("heach", {
    t("{{#each "), i(1, "items"), t("}}"),
    t({"", "  "}), i(0),
    t({"", "{{/each}}"}),
  }),
})



ls.add_snippets("go", {
  -- El famoso 'if err != nil'
  s("iferr", {
    t("if err != nil {"),
    t({"", "  return "}), i(1, "nil, err"),
    t({"", "}"}),
    i(0)
  }),

  -- Estructura de un método (Receiver)
  s("meth", {
    t("func ("), i(1, "r"), t(" *"), i(2, "Type"), t(") "), i(3, "Name"), t("("), i(4), t(") "), i(5, "error"), t(" {"),
    t({"", "  "}), i(0),
    t({"", "}"}),
  }),

  s("field", {
    i(1, "Name"), t(" "), i(2, "string"), t(' `json:"'),
    f(function(args)
      return string.lower(args[1][1])
    end, {1}),
    t('"`'),
    i(0)
  }),

  s("jt", {
    t('`json:"'),
    -- Este nodo lee lo que escribes en el insert_node(1)
    f(function(args)
      return string.lower(args[1][1]) -- Lo convierte a minúsculas
    end, {1}),
    t('"`'),
    i(1, "NombrePropiedad"), -- Aquí escribes tú

  }),

  -- Snippet para campos de Struct con JSON/DB tag automático
  s("fdb", {
    i(1, "NombreCampo"), t(" "), i(2, "string"),
    t(' `json:"'), f(snake_case, {1}),
    t('" db:"'), f(snake_case, {1}), t('"`'),
    i(0)
  }),
-- Query SELECT rápida
  s("sqsel", {
    t('query := `SELECT '), i(1, "*"), t(' FROM '), i(2, "table_name"), t(' WHERE '), i(3, "id"), t(' = ?`'),
    t({"", "rows, err := db.Query(query, "}), i(4, "id"), t(")"),
    t({"", "if err != nil {"}),
    t({"", "  return err"}),
    t({"", "}"}),
    i(0)
  }),

  -- Query INSERT con snake_case automático
  s("sqins", {
    t('query := `INSERT INTO '), i(1, "table_name"), t(' ('),
    f(snake_case, {2}), -- Transformamos el nombre del campo a snake_case
    t(') VALUES (?)`'),
    t({"", "_, err := db.Exec(query, "}), i(2, "Value"), t(")"),
    i(0)
  }),

  -- Contexto con Timeout (Muy común en producción)
  s("ctx", {
    t('ctx, cancel := context.WithTimeout(context.Background(), '), i(1, "5"), t('*time.Second)'),
    t({"", "defer cancel()"}),
    i(0)
  }),

  s("sqscan", {
    t("for rows.Next() {"),
    t({"", "  err := rows.Scan(&"}), i(1, "dest"), t(")"),
    t({"", "  if err != nil {"}),
    t({"", "    return err"}),
    t({"", "  }"}),
    t({"", "}"}),
    i(0)
  }),

  -- Query para crear una tabla (DDL)
  s("sqtable", {
    t('query := `CREATE TABLE IF NOT EXISTS '), i(1, "name"), t(' ('),
    t({"", "    id SERIAL PRIMARY KEY,"}),
    t({"", "    "}), i(2, "column_name"), t(" "), i(3, "type"),
    t({"", ");`"}),
    i(0)
  }),

  -- Update con múltiples campos
  s("squp", {
    t('query := `UPDATE '), i(1, "table"), 
    t(' SET '), i(2, "column"), t(' = ? WHERE '), i(3, "id"), t(' = ?`'),
    t({"", "result, err := db.Exec(query, "}), i(4, "val"), t(", "), i(5, "id"), t(")")
  }),
})

ls.add_snippets("javascript", {
  -- Crear una ruta de Express rápida
  s("exget", {
    t("router.get('/"), i(1, "path"), t("', (req, res) => {"),
    t({"", "  "}), i(0),
    t({"", "});"}),
  }),

  -- Console log rápido
  s("clg", {
    t("console.log('--- "), i(1, "DEBUG"), t(" ---');"),
    t({"", "console.log("}), i(2), t(");"),
  }),

  -- Función flecha (Arrow function)
  s("afn", {
    t("("), i(1, "args"), t(") => {"),
    t({"", "  "}), i(0),
    t({"", "}"}),
  }),
})


-- Hacer que handlebars herede los snippets de html
ls.filetype_extend("handlebars", { "html" })

-- Si usas javascriptreact (JSX), también podrías querer:
ls.filetype_extend("javascriptreact", { "html" })
-- Permite usar snippets de SQL dentro de archivos Go
ls.filetype_extend("go", { "sql" })

