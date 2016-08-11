require_relative "helper"

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

  def test_add_to_raw
    raw_to = "a@b.c;abc@example.com"
    @mailer.add_to_raw!(raw_to)
    assert_equal(raw_to, @mailer.to)
  end

  def test_add_cc_raw
  end

  def test_valid
    assert_equal(false, @mailer.valid?)
  end

  def test_build_as_mailto
    assert_equal(false, @mailer.build_as_mailto)
  end

  def test_attachfile
    assert_equal("", @mailer.attachments)
  end

  def test_build_html_body
  end
end