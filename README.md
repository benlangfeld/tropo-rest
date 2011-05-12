TropoREST
--------

TropoREST provides a wrapper for the Tropo REST API and also for Troplets.

Installation
============
    gem install tropo-rest

Library
=======

    require 'tropo-rest'
    TropoREST.tokens = {tropo: {voice: 'your_voice_token', messaging: 'your_messaging_token'}, troplets: {voice: 'your_troplets_voice_token', messaging: 'your_troplets_messaging_token'}}

    TropoREST.originate some_options_hash

Check out the [YARD documentation](http://rdoc.info/github/benlangfeld/tropo-rest/master/frames) for more

Console
=======

TropoREST comes with a basic console for testing purposes. You can launch it via the `tropo-rest` binary and you will be asked for your application tokens. You can alternatively provide them as arguments in the order tropo\_voice, tropo\_messaging, troplets\_voice, troplets\_messaging.


Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  * If you want to have your own version, that is fine but bump version in a commit by itself so I can ignore when I pull
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2011 Ben Langfeld. MIT licence (see LICENSE for details).
