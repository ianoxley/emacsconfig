;; elfeed.el

(unless (package-installed-p 'elfeed)
  (package-install 'elfeed))

(require 'elfeed)

(global-set-key (kbd "C-x w") 'elfeed)

(setq elfeed-feeds
	'(("http://shiflett.org/rss" security web)
	  ("https://blog.rendle.io/feed/" .net)
	  ("http://coreygoldberg.blogspot.com/feeds/posts/default" python linux ubuntu)
	  ("https://donmelton.com/feed/" apple)
	  ("http://feeds.feedburner.com/dcurtis?format=xml" design)
	  ("http://emacsrocks.com/atom.xml" emacs)
	  ("http://googletesting.blogspot.com/feeds/posts/default" google testing)
	  ("http://www.stevesouders.com/blog/feed/" web performance)
	  ("http://feeds.igvita.com/igvita" web performance)
	  ("http://blog.leahculver.com/atom.xml" python web)
	  ("http://martinfowler.com/bliki/bliki.atom" programming)
	  ;; ("http://morethanseven.net/articles.atom" web programming)
	  ("http://paulirish.com/feed/" web chrome javascript)
	  ("http://feeds.feedburner.com/PersistentInfo" programming web)
	  ("http://pragprog.com/feed/global" programming books)
	  ("http://samsaffron.com/posts.rss" web programming ruby)
	  ("http://feeds.hanselman.com/ScottHanselman" web programming .net)
	  ("http://weblogs.asp.net/scottgu/rss.aspx" web programming .net)
	  ("http://engineering.twitter.com/feeds/posts/default?alt=rss" twitter programming)
	  ("http://whattheemacsd.com/atom.xml" emacs)
	  ("http://xkcd.com/atom.xml" comic)
	  ("http://feeds.haacked.com/haacked/" programming github .net)
	  ("http://www.howardism.org/index.xml" emacs programming)
	  ("http://nullprogram.com/feed/" emacs programming)
	  ("http://endlessparentheses.com/atom.xml" emacs)
	  ("http://techblog.netflix.com/feeds/posts/default" programming netflix)
	  ("http://planet.emacsen.org/atom.xml" emacs)))

