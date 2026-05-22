import re

with open("index.html", "r", encoding="utf-8") as f:
    text = f.read()

# 1. 删除 langToggle 按钮
text = text.replace('<button class="lang-toggle" id="langToggle" title="切换语言">EN</button>', '')

# 2. 删除所有 data-i18n 属性
text = re.sub(r' data-i18n="[^"]*"', '', text)

# 3. 删除 langData = null; 到第一个 // ================================ 之间的所有代码
start = text.find("var langData = null;")
end = text.find("// =================================", start)
if start >= 0 and end > start:
    text = text[:start] + text[end:]

# 4. 删除 applyLang 函数
start = text.find("function applyLang(lang)")
end = text.find("\n\n// =========================", start)
if start >= 0 and end > start:
    text = text[:start] + text[end:]

# 5. 删除 loadLangData 函数
start = text.find("function loadLangData()")
end = text.find("\n\n// =========================", start)
if start >= 0 and end > start:
    text = text[:start] + text[end:]

# 6. 删除 langBtn.addEventListener 块
start = text.find("langBtn.addEventListener")
end = text.find("\n\n// =========================", start)
if start >= 0 and end > start:
    text = text[:start] + text[end:]

# 7. 删除所有残留的 langBtn、currentLang 相关行
text = text.replace("var langBtn = document.getElementById('langToggle');", "")
text = text.replace("var currentLang = 'zh';", "")
text = text.replace("loadLangData();", "")
text = text.replace("applyLang(currentLang);", "")
text = text.replace("localStorage.getItem('so-lang') || 'zh';", "'zh';")

# 8. 清理多余的空行
text = re.sub(r'\n{3,}', '\n\n', text)

# 9. 删除空 script 块
text = text.replace("<script>\n</script>", "")

# 验证
for term in ["langData", "data-i18n", "applyLang", "loadLangData", "currentLang", "langBtn", "langToggle"]:
    count = text.count(term)
    status = "OK" if count == 0 else f"WARNING: {count} remaining"
    print(f"  {term}: {status}")

print(f"\nFile size: {len(text)} chars")

with open("index.html", "w", encoding="utf-8") as f:
    f.write(text)

print("Done!")
