$text = Get-Content "index.html" -Raw -Encoding UTF8

# 1. 删除 langToggle 按钮
$text = $text.Replace('<button class="lang-toggle" id="langToggle" title="切换语言">EN</button>', '')

# 2. 删除所有 data-i18n 属性
$text = [regex]::Replace($text, ' data-i18n="[^"]*"', '')

# 3. 删除 langData 到 initLang 之间的所有JS代码
$ldstart = $text.IndexOf("var langData = null;")
$ldend = $text.IndexOf("// =================================", $ldstart)
if ($ldstart -ge 0 -and $ldend -gt $ldstart) {
  $text = $text.Substring(0, $ldstart) + $text.Substring($ldend)
}

# 4. 删除残留的 applyLang 函数
$afstart = $text.IndexOf("function applyLang(lang)")
$afend = $text.IndexOf("`n`n// =========================", $afstart)
if ($afstart -ge 0 -and $afend -gt $afstart) {
  $text = $text.Substring(0, $afstart) + $text.Substring($afend)
}

# 5. 删除 loadLangData 函数
$lfstart = $text.IndexOf("function loadLangData()")
$lfend = $text.IndexOf("`n`n// =========================", $lfstart)
if ($lfstart -ge 0 -and $lfend -gt $lfstart) {
  $text = $text.Substring(0, $lfstart) + $text.Substring($lfend)
}

# 6. 删除 langBtn 事件监听
$lbstart = $text.IndexOf("langBtn.addEventListener")
$lbend = $text.IndexOf("`n`n// =========================", $lbstart)
if ($lbstart -ge 0 -and $lbend -gt $lbstart) {
  $text = $text.Substring(0, $lbstart) + $text.Substring($lbend)
}

# 7. 删除剩下的所有 langBtn、currentLang 相关代码
$text = $text.Replace("var langBtn = document.getElementById('langToggle');", "")
$text = $text.Replace("var currentLang = 'zh';", "")
$text = $text.Replace("loadLangData();", "")
$text = $text.Replace("applyLang(currentLang);", "")

# 8. 清理空的 script 块
$text = [regex]::Replace($text, "`n`n`n+", "`n`n")

Set-Content "index.html" $text -Encoding UTF8
Write-Host "Done"
