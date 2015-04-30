BIBLE_URLS = {
  'web.usfx.xml' => 'https://www.dropbox.com/sh/zcmi19piind3eff/AAA8yQYyVE6mNUqtlzLtaKwta/web.usfx.xml?dl=1'
}

namespace :spec do
  desc 'Download example bible files to run specs'
  task :prepare do
    BIBLE_URLS.each do |file, url|
      `curl -vL -o tmp/#{file} #{url}`
    end
  end
end
