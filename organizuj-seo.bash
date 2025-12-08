#!/bin/bash
echo "🚀 Počinjem reorganizaciju za SEO..."

# 1. Kreiraj foldere
echo "📁 Kreiram strukturu foldera..."
mkdir -p nauka blog/ph-vrednost blog/prirodni-sastojci
mkdir -p legal/reklamacije legal/uslovi legal/privatnost

# 2. Premesti fajlove ako postoje
echo "📦 Premeštam fajlove..."
[ -f "nauka.html" ] && mv nauka.html nauka/index.html && echo "✅ nauka.html → nauka/index.html"
[ -f "blog/ph-vrednost.html" ] && mv blog/ph-vrednost.html blog/ph-vrednost/index.html && echo "✅ blog/ph-vrednost.html → blog/ph-vrednost/index.html"
[ -f "blog/prirodni-sastojci.html" ] && mv blog/prirodni-sastojci.html blog/prirodni-sastojci/index.html && echo "✅ blog/prirodni-sastojci.html → blog/prirodni-sastojci/index.html"
[ -f "reklamacije.html" ] && mv reklamacije.html legal/reklamacije/index.html && echo "✅ reklamacije.html → legal/reklamacije/index.html"
[ -f "uslovi.html" ] && mv uslovi.html legal/uslovi/index.html && echo "✅ uslovi.html → legal/uslovi/index.html"
[ -f "privatnost.html" ] && mv privatnost.html legal/privatnost/index.html && echo "✅ privatnost.html → legal/privatnost/index.html"

# 3. Kreiraj konfiguracione fajlove
echo "⚙️ Kreiram konfiguracione fajlove..."

# SITEMAP
cat > sitemap.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://pulsgel.github.io/PulsGel/</loc>
    <lastmod>2025-11-26</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://pulsgel.github.io/PulsGel/nauka/</loc>
    <lastmod>2025-11-26</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>https://pulsgel.github.io/PulsGel/blog/ph-vrednost/</loc>
    <lastmod>2025-11-26</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>https://pulsgel.github.io/PulsGel/blog/prirodni-sastojci/</loc>
    <lastmod>2025-11-26</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
  <url>
    <loc>https://pulsgel.github.io/PulsGel/legal/reklamacije/</loc>
    <lastmod>2025-11-26</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>
  <url>
    <loc>https://pulsgel.github.io/PulsGel/legal/uslovi/</loc>
    <lastmod>2025-11-26</lastmod>
    <changefreq>yearly</changefreq>
    <priority>0.6</priority>
  </url>
  <url>
    <loc>https://pulsgel.github.io/PulsGel/legal/privatnost/</loc>
    <lastmod>2025-11-26</lastmod>
    <changefreq>yearly</changefreq>
    <priority>0.6</priority>
  </url>
</urlset>
EOF
echo "✅ sitemap.xml kreiran"

# ROBOTS.TXT
cat > robots.txt << 'EOF'
User-agent: *
Allow: /
Disallow: /admin/
Disallow: /tmp/
Disallow: /private/

Sitemap: https://pulsgel.github.io/PulsGel/sitemap.xml
EOF
echo "✅ robots.txt kreiran"

# REDIRECTS
cat > _redirects << 'EOF'
/nauka.html    /nauka/    301
/blog/ph-vrednost.html    /blog/ph-vrednost/    301
/blog/prirodni-sastojci.html    /blog/prirodni-sastojci/    301
/reklamacije.html    /legal/reklamacije/    301
/uslovi.html    /legal/uslovi/    301
/privatnost.html    /legal/privatnost/    301
EOF
echo "✅ _redirects kreiran"

echo "🎉 Organizacija završena!"
echo ""
echo "🌐 NOVI URL-OVI:"
echo "   • https://pulsgel.github.io/PulsGel/nauka/"
echo "   • https://pulsgel.github.io/PulsGel/blog/ph-vrednost/"
echo "   • https://pulsgel.github.io/PulsGel/blog/prirodni-sastojci/"
echo ""
echo "🛠️ Sledeći korak: Ažuriraj linkove u HTML fajlovima."
