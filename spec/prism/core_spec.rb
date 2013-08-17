require "spec_helper"

describe Prism::Core do
  describe "stack_trace_for_group" do
    it "returns a StackTrace with a unique identifier and a file set" do
      core = Prism::Core.new

      example_group = RSpec::Core::ExampleGroup.describe("my favorite class")
      example_group.example("foos the bar") do
        object = TestClass.new
        object.invoke_a_method
      end

      trace = core.stack_trace_for_group(example_group, NullObject.new)
      trace.location.should == "spec/prism/core_spec.rb:8"
      trace.file_set.should include("spec/spec_helper.rb")
    end
  end

  describe "files_scope_for_diff" do
    it "generates a set of files" do
      core = Prism::Core.new
      diff = <<-END
diff --git a/app/middlewares/database_reconnect.rb b/app/middlewares/database_reconnect.rb
index 70ec3b0..054be11 100644
--- a/app/middlewares/database_reconnect.rb
+++ b/app/middlewares/database_reconnect.rb
@@ -1,7 +1,4 @@
 class DatabaseReconnect
-  def initialize(app)
-    @app = app
-  end

   def call(env)
     _check_and_reconnect
diff --git a/app/models/card.rb b/app/models/card.rb
index 7e6cbee..71f5381 100644
--- a/app/models/card.rb
+++ b/app/models/card.rb
@@ -1,8 +1,4 @@
 class Card < ActiveRecord::Base
-  attr_accessible :encryption_key_id, :deleted_at, :public_id, :bin
-  default_scope where(:deleted_at => nil)
-  belongs_to :originating_merchant, :class_name => "Merchant"
-  belongs_to :user
   has_many :card_merchants
   has_many :merchants, :through => :card_merchants, :order => 'merchant_to_card.last_used_at DESC'

diff --git a/app/models/exceptions.rb b/app/models/exceptions.rb
index a6888ad..6734429 100644
--- a/app/models/exceptions.rb
+++ b/app/models/exceptions.rb
@@ -1,4 +1,8 @@
 class ApiException < StandardError
+  attr_accessible :encrypted_number, :last_four, :expiration_month, :expiration_year, :card_type, :encryption_key_id,
 :durbin_regulated, :debit, :deleted_at, :number_hash, :zipcode, :public_id, :bin
+  default_scope where(:deleted_at => nil)
+  belongs_to :originating_merchant, :class_name => "Merchant"
+  belongs_to :user
   attr_reader :error_code, :message, :show_to_user, :title

   def initialize(error_code, message, show_to_user, title)
END

      files = core.files_in_scope_for_diff(diff)

      files.should == Set.new(["app/middlewares/database_reconnect.rb", "app/models/card.rb", "app/models/exceptions.rb"])
    end
  end

  describe "run_and_save_trace!" do
    it "runs the example group and records the files needed to run" do
      core = Prism::Core.new

      example_group = RSpec::Core::ExampleGroup.describe("my favorite class")
      example_group.example("foos the bar") do
        object = TestClass.new
        object.invoke_a_method
      end

      core.run_and_save_trace!(example_group, NullObject.new)

      core.get_saved_trace(example_group).should == core.stack_trace_for_group(example_group, NullObject.new)
    end

    it "saves each stack trace to a unique location" do
      core = Prism::Core.new

      example_group_one = RSpec::Core::ExampleGroup.describe("my favorite class")
      example_group_one.example("foos the bar") do
        object = TestClass.new
        object.invoke_a_method
      end

      core.run_and_save_trace!(example_group_one, NullObject.new)

      example_group_two = RSpec::Core::ExampleGroup.describe("a class I don't like")
      example_group_two.example("bars the foo") do
        object = TestClass.new
        object.invoke_a_bad_method
      end

      core.run_and_save_trace!(example_group_two, NullObject.new)

      core.get_saved_trace(example_group_one).should_not == core.get_saved_trace(example_group_two)
    end
  end
end
