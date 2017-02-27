# -*- encoding: utf-8 -*-
# stub: minitest-coverage 1.0.0.b1 ruby lib

Gem::Specification.new do |s|
  s.name = "minitest-coverage".freeze
  s.version = "1.0.0.b1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ryan Davis".freeze]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDijCCAnKgAwIBAgIBATANBgkqhkiG9w0BAQUFADBFMRMwEQYDVQQDDApyeWFu\nZC1ydWJ5MRkwFwYKCZImiZPyLGQBGRYJemVuc3BpZGVyMRMwEQYKCZImiZPyLGQB\nGRYDY29tMB4XDTE2MDkyNjAxNTczNVoXDTE3MDkyNjAxNTczNVowRTETMBEGA1UE\nAwwKcnlhbmQtcnVieTEZMBcGCgmSJomT8ixkARkWCXplbnNwaWRlcjETMBEGCgmS\nJomT8ixkARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALda\nb9DCgK+627gPJkB6XfjZ1itoOQvpqH1EXScSaba9/S2VF22VYQbXU1xQXL/WzCkx\ntaCPaLmfYIaFcHHCSY4hYDJijRQkLxPeB3xbOfzfLoBDbjvx5JxgJxUjmGa7xhcT\noOvjtt5P8+GSK9zLzxQP0gVLS/D0FmoE44XuDr3iQkVS2ujU5zZL84mMNqNB1znh\nGiadM9GHRaDiaxuX0cIUBj19T01mVE2iymf9I6bEsiayK/n6QujtyCbTWsAS9Rqt\nqhtV7HJxNKuPj/JFH0D2cswvzznE/a5FOYO68g+YCuFi5L8wZuuM8zzdwjrWHqSV\ngBEfoTEGr7Zii72cx+sCAwEAAaOBhDCBgTAJBgNVHRMEAjAAMAsGA1UdDwQEAwIE\nsDAdBgNVHQ4EFgQUR8V72Z3+v+2P9abCnL4wjx32T+EwIwYDVR0RBBwwGoEYcnlh\nbmQtcnVieUB6ZW5zcGlkZXIuY29tMCMGA1UdEgQcMBqBGHJ5YW5kLXJ1YnlAemVu\nc3BpZGVyLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAIGzgp0aZ2W9+v96ujmBcQHoC\nbuy0iU68MVj2VlxMyfr1KPZIh1OyhU4UO4zrkREcH8ML70v9cYHNvOd9oynRHnvC\nl2tj/fD3YJ0AEkJxGrYwRWQmvMfC4bJ02bC1+rVOUIXXKp3+cUmiN4sTniof8VFo\nbo/YYP4c7erpERa+9hrqygg6WQbJlk2YRlH3JXPFjmu869i2dcbR5ZLOAeEy+axH\nE4oJcnPkJAr0rw504JGtlZtONZQblwmRJOIdXzolaE3NRGUzGVOUSptZppAKiavY\nfO6tdKQc/5RfA8oQEkg8hrxA5PQSz4TOFJGLpFvIapEk6tMruQ0bHgkhr9auXg==\n-----END CERTIFICATE-----\n".freeze]
  s.date = "2016-11-10"
  s.description = "Ruby's contemporary test coverage tools all lie, exaggerating coverage\nthrough false-positives and creating a false sense of security;\nminitest-coverage tries to address this.\n\nCoverage Analysis Tools rely on tracing facilities built into ruby\u2019s\nVM. You run your tests, and collect data. Seems simple, but that\u2019s a\nvery flawed approach that buffers your coverage numbers up falsely.\nI\u2019ve witnessed false coverage by as much as 60%, but it could be even\nworse. Worse, the tracing facilities currently make it impossible to\nget truly accurate numbers. Even so, they can be improved to be much\nmore accurate.".freeze
  s.email = ["ryand-ruby@zenspider.com".freeze]
  s.executables = ["minitest_coverage".freeze, "minitest_coverage_baseline".freeze, "minitest_coverage_issues".freeze, "minitest_coverage_report".freeze]
  s.extra_rdoc_files = ["History.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze]
  s.files = ["History.rdoc".freeze, "Manifest.txt".freeze, "README.rdoc".freeze, "bin/minitest_coverage".freeze, "bin/minitest_coverage_baseline".freeze, "bin/minitest_coverage_issues".freeze, "bin/minitest_coverage_report".freeze]
  s.homepage = "https://github.com/seattlerb/minitest-coverage".freeze
  s.licenses = ["MIT".freeze]
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.rubygems_version = "2.6.8".freeze
  s.summary = "Ruby's contemporary test coverage tools all lie, exaggerating coverage through false-positives and creating a false sense of security; minitest-coverage tries to address this".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>.freeze, ["~> 3.15"])
    else
      s.add_dependency(%q<hoe>.freeze, ["~> 3.15"])
    end
  else
    s.add_dependency(%q<hoe>.freeze, ["~> 3.15"])
  end
end
