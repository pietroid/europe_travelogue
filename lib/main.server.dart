/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

// Server-specific Jaspr import.
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import 'package:jaspr_content/components/callout.dart';
import 'package:jaspr_content/components/code_block.dart';
import 'package:jaspr_content/components/header.dart';
import 'package:jaspr_content/components/image.dart';
import 'package:jaspr_content/components/sidebar.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';

import 'components/clicker.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() {
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  // 1. Initialize and configure AssetManager.
  final assetManager = AssetManager(
    // The root directory where your assets are located. Usually, this is the same as your content directory.
    directory: 'images',
    // Optional: Configure which properties in your frontmatter contain asset paths.
    dataProperties: {'image', 'meta.thumbnail'},
    outputPrefix: 'europe_travelogue/assets',
  );

  // 2. Add middleware to serve assets during development.
  ServerApp.addMiddleware(assetManager.middleware);

  // Starts the app.
  //
  // [ContentApp] spins up the content rendering pipeline from jaspr_content to render
  // your markdown files in the content/ directory to a beautiful documentation site.
  runApp(
    Document(
      base: "europe_travelogue",
      /* ... */
      // other properties
      head: [
        link(
          rel: 'preconnect',
          href: 'https://fonts.googleapis.com',
        ),
        link(
          rel: 'preconnect',
          href: 'https://fonts.gstatic.com',
          attributes: {'crossorigin': ''},
        ),
        link(
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Gilda+Display&display=swap',
        ),
      ],
      body: ContentApp(
        // Enables mustache templating inside the markdown files.
        templateEngine: MustacheTemplateEngine(),
        parsers: [
          MarkdownParser(),
        ],
        extensions: [
          // Adds heading anchors to each heading.
          HeadingAnchorsExtension(),
          // Generates a table of contents for each page.
          //TableOfContentsExtension(),
          assetManager.pageExtension,
        ],
        components: [
          // The <Info> block and other callouts.
          Callout(),
          // Adds syntax highlighting to code blocks.
          CodeBlock(),
          // Adds a custom Jaspr component to be used as <Clicker/> in markdown.
          CustomComponent(
            pattern: 'Clicker',
            builder: (_, _, _) => Clicker(),
          ),
          // Adds zooming and caption support to images.
          Image(zoom: true),
        ],
        layouts: [
          // Out-of-the-box layout for documentation sites.
          DocsLayout(
            header: Header(
              title: 'Europa: Jornada do coração',
              logo: '/images/logo.svg',
              items: [],
            ),
            sidebar: Sidebar(
              groups: [
                // Adds navigation links to the sidebar.
                SidebarGroup(
                  links: [
                    SidebarLink(text: "Overview", href: '/'),
                  ],
                ),
                SidebarGroup(
                  title: 'Content',
                  links: [
                    SidebarLink(text: "About", href: '/about'),
                  ],
                ),
              ],
            ),
          ),
        ],
        theme: ContentTheme(
          font: FontFamily('Gilda Display'),
          background: ThemeColor(Color("#F0D3D7")),
          colors: [
            ContentColors.text.apply(Color("#3B0D13")),
            ContentColors.headings.apply(Color("#6D0002")),
            ContentColors.links.apply(Color("#C8003F")),
            ContentColors.quoteBorders.apply(Color("#C8003F")),
            ContentColors.quotes.apply(Color("#C8003F")),
            ContentColors.captions.apply(Color("#6D0002")),
          ],
          typography: ContentTypography.base.apply(
            styles: Styles(
              lineHeight: Unit.em(1.5),
              textAlign: TextAlign.justify,
              margin: Margin.fromLTRB(
                Unit.em(0),
                Unit.em(1),
                Unit.em(1),
                Unit.em(1),
              ),
            ),
            rules: [],
          ),
        ),
      ),
    ),
  );
}
