# encoding: utf-8

require 'xcpretty'
require 'fixtures/constants'

module XCPretty

	describe Reporter do 
		before(:each) do
			@reporter = Reporter.new(path: "example_file")
		end
	end

	it "reports a passing test" do 
		@reporter.format_passing_test("RACCommandSpec", "_tupleByAddingObject__should_add_a_non_nil_object", "0.001")
		expect(@reporter.tests).to include("_tupleByAddingObject__should_add_a_non_nil_object PASSED")
	end

	it "reports a failing test" do
		@reporter.format_failing_test("RACCommandSpec", "enabled_signal_should_send_YES_while_executing_is_YES_and_allowsConcurrentExecution_is_YES", "expected: 1, got: 0", 'path/to/file')
		expect(@reporter.tests).to include("enabled_signal_should_send_YES_while_executing_is_YES_and_allowsConcurrentExecution_is_YES in path/to/file FAILED: expected: 1, got: 0")
	end

	it "reports a pending test" do
		@reporter.format_pending_text("RACCommandSpec", "_tupleByAddingObject__should_add_a_non_nil_object")
		expect(@reporter.tests).to include("_tupleByAddingObject__should_add_a_non_nil_object IS PENDING")
	end

	it "writes to disk" do 
		@reporter.format_passing_test("RACCommandSpec", "_tupleByAddingObject__should_add_a_non_nil_object", "0.001")
		
		File.stub(:write)
		@reporter.write_report

		expect(File).to have_received(:write).with("example_file", "_tupleByAddingObject__should_add_a_non_nil_object PASSED\nFINISHED RUNNING 1 TESTS WITH 0 FAILURES")
	end
end