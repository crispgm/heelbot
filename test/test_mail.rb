require "helper"

class TestMail < Minitest::Test
  def setup
    @mailer = Heel::MailHelper.new
  end

  def test_init
    assert_equal("", @mailer.from)
    assert_equal("", @mailer.to)
    assert_equal("", @mailer.cc)
    assert_equal("", @mailer.subject)
    assert_equal("", @mailer.body)
    assert_equal("", @mailer.attachments)
  end

  def test_add_to
    ary_names = ["a", "b", "c"]
    @mailer.add_to!(ary_names, "@example.to")
    assert_equal("a@example.to;b@example.to;c@example.to;", @mailer.to)
  end

  def test_add_cc
    ary_names = ["a", "b", "c"]
    @mailer.add_cc!(ary_names, "@example.cc")
    assert_equal("a@example.cc;b@example.cc;c@example.cc;", @mailer.cc)
  end

  def test_add_to_raw
    raw_to = "a@b.c;abc@example.com"
    @mailer.add_to_raw!(raw_to)
    assert_equal(raw_to, @mailer.to)
  end

  def test_add_cc_raw
    raw_cc = "a@b.cc;abc@example.com"
    @mailer.add_cc_raw!(raw_cc)
    assert_equal(raw_cc, @mailer.cc)
  end

  def test_valid
    assert_equal(false, @mailer.valid?)
    raw_to = "a@b.c;abc@example.com"
    @mailer.add_to_raw!(raw_to)
    assert_equal(true, @mailer.valid?)
  end

  def test_valid_strict
    assert_equal(false, @mailer.valid_strict?)
    raw_to = "a@b.c;abc@example.com"
    @mailer.add_to_raw!(raw_to)
    assert_equal(false, @mailer.valid_strict?)
    @mailer.subject = "TestMail"
    assert_equal(false, @mailer.valid_strict?)
    @mailer.body = "Test Main"
    assert_equal(true, @mailer.valid_strict?)
  end

  def test_build_as_mailto
    assert_equal(false, @mailer.build_as_mailto)
    @mailer.to = "abc@example.com"
    @mailer.cc = "test@example.cc"
    @mailer.subject = "TestMail"
    @mailer.body = "Test Main"
    assert_equal("mailto:abc@example.com?cc=test@example.cc&subject=TestMail&body=Test Main", @mailer.build_as_mailto)
  end

  def test_attachfile
    assert_equal("", @mailer.attachments)
  end

  def test_build_html_body
  end
end