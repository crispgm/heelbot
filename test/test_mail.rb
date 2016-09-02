require "helper"

class TestMail < Minitest::Test
  context "test mail" do
    setup do
      @mailer = Heel::MailHelper.new
    end

    should "init with empty " do
      assert_equal("", @mailer.from)
      assert_equal("", @mailer.to)
      assert_equal("", @mailer.cc)
      assert_equal("", @mailer.subject)
      assert_equal("", @mailer.body)
      assert_equal("", @mailer.attachments)
    end

    should "add items to @to list" do
      ary_names = ["a", "b", "c"]
      @mailer.add_to!(ary_names, "@example.to")
      assert_equal("a@example.to;b@example.to;c@example.to;", @mailer.to)
    end

    should "add items to @cc list" do
      ary_names = ["a", "b", "c"]
      @mailer.add_cc!(ary_names, "@example.cc")
      assert_equal("a@example.cc;b@example.cc;c@example.cc;", @mailer.cc)
    end

    should "add raw emails to @to list" do
      raw_to = "a@b.c;abc@example.com"
      @mailer.add_to_raw!(raw_to)
      assert_equal(raw_to, @mailer.to)
    end

    should "add raw emails to @cc list" do
      raw_cc = "a@b.cc;abc@example.com"
      @mailer.add_cc_raw!(raw_cc)
      assert_equal(raw_cc, @mailer.cc)
    end

    should "valid mail address" do
      assert_equal(false, @mailer.valid?)
      raw_to = "a@b.c;abc@example.com"
      @mailer.add_to_raw!(raw_to)
      assert_equal(true, @mailer.valid?)
    end

    should "valid mail strictly" do
      assert_equal(false, @mailer.valid_strict?)
      raw_to = "a@b.c;abc@example.com"
      @mailer.add_to_raw!(raw_to)
      assert_equal(false, @mailer.valid_strict?)
      @mailer.subject = "TestMail"
      assert_equal(false, @mailer.valid_strict?)
      @mailer.body = "Test Main"
      assert_equal(true, @mailer.valid_strict?)
    end

    should "build as mailto proto" do
      assert_equal(false, @mailer.build_as_mailto)
      @mailer.to = "abc@example.com"
      @mailer.cc = "test@example.cc"
      @mailer.subject = "TestMail"
      @mailer.body = "Test Main"
      assert_equal("mailto:abc@example.com?cc=test@example.cc&subject=TestMail&body=Test Main", @mailer.build_as_mailto)
    end

    # TODO
    should "attach files" do
      assert_equal("", @mailer.attachments)
    end

    should "build html body" do
    end
  end
end