# Battle

## Security and runtime update

Use a supported Ruby version (3.2 or later), install the locked gems, and run `bundle exec rspec`. Start locally with `bundle exec rackup -s webrick -o 127.0.0.1`. The 16-example suite, including session-isolation, CSRF and HTML-escaping regressions, passed on JRuby 10.1.3.0 (Ruby 4.0.9). Audit dependencies used checksum-verified pure Ruby or precompiled Java gems; native extension scripts were not run.

Each browser now keeps its own game state in its protected session cookie. Attacks and turn changes require POST forms and a per-session CSRF token. Player names are escaped in templates and limited to 80 characters. Sinatra, Rack and session middleware are updated; obsolete development-server and unused browser-driver dependencies were removed.

Production startup requires `SESSION_SECRET` containing at least 64 random bytes. Generate a secret securely and configure it through the existing deployment's environment; do not commit it. Production cookies use Secure, HttpOnly and SameSite=Lax. Local development uses an ephemeral random key, so restarting the app resets local sessions.
