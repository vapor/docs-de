cd docs;
mkdocs build;
cd ..;

rm -rf site
mkdir -p site;

mv docs/site site/docs;

echo "<meta http-equiv=\"refresh\" content=\"0; url=/4.0/\">" > site/index.html;