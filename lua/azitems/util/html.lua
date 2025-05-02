local html_entities = {
  ["&quot;"] = "\"", ["&nbsp;"] = " ", ["&lt;"] = "<", ["&gt;"] = ">", ["&amp;"] = "&"
}

local function unescape_html(str)
  return (str:gsub("(&[%a#0-9]+;)", function(entity)
    return html_entities[entity] or entity
  end))
end

function convertHtmlToMd(html)
  html = unescape_html(html)
  html = html:gsub("<hr[^>]*>", "\n---\n")
  html = html:gsub("<br%s*/?>", "\n")
  html = html:gsub("<b>(.-)</b>", "*%1*")
  html = html:gsub("<p>(.-)</p>", "\n%1\n")
  html = html:gsub("<div[^>]*>", "")
  html = html:gsub("</div>", "")
  html = html:gsub("<tr>", "")
  html = html:gsub("</tr>", "\n")
  html = html:gsub("<td[^>]*>", "")
  html = html:gsub("</td>", "\t")
  html = html:gsub("<table[^>]*>", "\n")
  html = html:gsub("</table>", "\n")
  html = html:gsub("<[^>]+>", "") -- strip any remaining tags
  html = html:gsub("\n+", "\n") -- compress newlines
  return html:match("^%s*(.-)%s*$") -- trim
end
