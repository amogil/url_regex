require 'url_regex'

describe UrlRegex do
  describe '.get' do
    it 'should allow :parsing as mode values' do
      expect(UrlRegex.get(mode: :parsing)).to be
    end

    it 'should raise ArgumentError if mode neither :validation nor :parsing' do
      expect { UrlRegex.get(mode: nil) }.to raise_error ArgumentError
    end
  end

  describe 'Full validation regex' do
    [
      'http://foo.com/blah_blah',
      'http://foo.com/blah_blah/',
      'http://foo.com/blah_blah_(wikipedia)',
      'http://foo.com/blah_blah_(wikipedia)_(again)',
      'http://www.example.com/wpstyle/?p=364',
      'https://www.example.com/foo/?bar=baz&inga=42&quux',
      'http://✪df.ws/123',
      'http://userid:password@example.com:8080',
      'http://userid:password@example.com:8080/',
      'http://userid@example.com',
      'http://userid@example.com/',
      'http://userid@example.com:8080',
      'http://userid@example.com:8080/',
      'http://userid:password@example.com',
      'http://userid:password@example.com/',
      'http://142.42.1.1/',
      'http://142.42.1.1:8080/',
      'http://➡.ws/䨹',
      'http://⌘.ws',
      'http://⌘.ws/',
      'http://foo.com/blah_(wikipedia)#cite-1',
      'http://foo.com/blah_(wikipedia)_blah#cite-1',
      'http://foo.com/unicode_(✪)_in_parens',
      'http://foo.com/(something)?after=parens',
      'http://☺.damowmow.com/',
      'http://code.google.com/events/#&product=browser',
      'http://j.mp',
      'ftp://foo.bar/baz',
      'http://foo.bar/?q=Test%20URL-encoded%20stuff',
      'http://مثال.إختبار',
      'http://例子.测试',
      'http://उदाहरण.परीक्षा',
      "http://-.~_!$&'()*+,;=:%40:80%2f::::::@example.com",
      'http://1337.net',
      'http://a.b-c.de',
      'http://a.b--c.de/',
      'http://www.foo.bar./',
      'http://223.255.255.254',
      'http://example.org?foo=bar'
    ].each do |valid_url|
      it "should match #{valid_url}" do
        expect(UrlRegex.get(scheme_required: true)).to match valid_url
      end
    end

    [
      'http://',
      'http://.',
      'http://..',
      'http://../',
      'http://?',
      'http://??',
      'http://??/',
      'http://#',
      'http://##',
      'http://##/',
      'http://foo.bar?q=Spaces should be encoded',
      '//',
      '//a',
      '///a',
      '///',
      'http:///a',
      'foo.com',
      'rdar://1234',
      'h://test',
      'http:// shouldfail.com',
      ':// should fail',
      'http://foo.bar/foo(bar)baz quux',
      'ftps://foo.bar/',
      'http://-error-.invalid/',
      'http://-a.b.co',
      'http://a.b-.co',
      'http://0.0.0.0',
      'http://10.1.1.0',
      'http://10.1.1.255',
      'http://224.1.1.1',
      'http://1.1.1.1.1',
      'http://123.123.123',
      'http://3628126748',
      'http://.www.foo.bar/',
      'http://.www.foo.bar./',
      'http://10.1.1.1',
      'http://10.1.1.254'
    ].each do |invalid_url|
      it "should not match #{invalid_url}" do
        expect(UrlRegex.get(scheme_required: true)).to_not match invalid_url
      end
    end
  end

  describe 'Optional scheme validation regex' do
    [
      'foo.com/blah_blah',
      'foo.com/blah_blah/',
      'foo.com/blah_blah_(wikipedia)',
      'foo.com/blah_blah_(wikipedia)_(again)',
      'www.example.com/wpstyle/?p=364',
      'www.example.com/foo/?bar=baz&inga=42&quux',
      '✪df.ws/123',
      'userid:password@example.com:8080',
      'userid:password@example.com:8080/',
      'userid@example.com',
      'userid@example.com/',
      'userid@example.com:8080',
      'userid@example.com:8080/',
      'userid:password@example.com',
      'userid:password@example.com/',
      '142.42.1.1/',
      '142.42.1.1:8080/',
      '➡.ws/䨹',
      '⌘.ws',
      '⌘.ws/',
      'foo.com/blah_(wikipedia)#cite-1',
      'foo.com/blah_(wikipedia)_blah#cite-1',
      'foo.com/unicode_(✪)_in_parens',
      'foo.com/(something)?after=parens',
      '☺.damowmow.com/',
      'code.google.com/events/#&product=browser',
      'j.mp',
      'foo.bar/baz',
      'foo.bar/?q=Test%20URL-encoded%20stuff',
      'مثال.إختبار',
      '例子.测试',
      'उदाहरण.परीक्षा',
      "-.~_!$&'()*+,;=:%40:80%2f::::::@example.com",
      '1337.net',
      'a.b-c.de',
      'a.b--c.de/',
      'www.foo.bar./',
      '223.255.255.254',
      'example.org?foo=bar',
      'google.com?t=2">Link</a>'
    ].each do |valid_url|
      it "should match #{valid_url}" do
        expect(UrlRegex.get(scheme_required: false)).to match valid_url
      end
    end

    [
      '',
      '.',
      '..',
      '../',
      '?',
      '??',
      '??/',
      '#',
      '##',
      '##/',
      'foo.bar?q=Spaces should be encoded',
      '//',
      '//a',
      '///a',
      '///',
      '/a',
      'rdar://1234',
      'h://test',
      ' shouldfail.com',
      ':// should fail',
      'foo.bar/foo(bar)baz quux',
      '-error-.invalid/',
      '-a.b.co',
      'a.b-.co',
      '0.0.0.0',
      '10.1.1.0',
      '10.1.1.255',
      '224.1.1.1',
      '1.1.1.1.1',
      '123.123.123',
      '3628126748',
      '.www.foo.bar/',
      '.www.foo.bar./',
      '10.1.1.1',
      '10.1.1.254'
    ].each do |invalid_url|
      it "should not match #{invalid_url}" do
        expect(UrlRegex.get(scheme_required: false)).to_not match invalid_url
      end
    end
  end

  describe 'Required scheme parsing regex' do
    let(:regex) { UrlRegex.get(scheme_required: true, mode: :parsing) }

    {
      'See here: http://google.com?a=1&b=2' => ['http://google.com?a=1&b=2'],
      'google.com - search engine' => [],
      '<a href="google.com?t=2">Link</a>' => [],
      'This text has many links:www.go.com?mode#anchor and https://t.co' => ['https://t.co']
    }.each do |text, valid_url|
      it "should parse '#{valid_url}' from '#{text}'" do
        expect(text.scan(regex)).to eq valid_url
      end
    end
  end

  describe 'Optional scheme parsing regex' do
    let(:regex) { UrlRegex.get(scheme_required: false, mode: :parsing) }

    {
      'See here: http://google.com?a=1&b=2' => ['http://google.com?a=1&b=2'],
      'google.com - search engine' => ['google.com'],
      '<a href="google.com?t=2">Link</a>' => ['google.com?t=2">Link</a>'],
      'This text has many links:www.go.com?mode#anchor and https://t.co' => ['www.go.com?mode#anchor', 'https://t.co']
    }.each do |text, valid_url|
      it "should parse '#{valid_url}' from '#{text}'" do
        expect(text.scan(regex)).to eq valid_url
      end
    end
  end
end
