require 'test/unit'
require 'mocha'
require 'when'

class FluentExecutionAPITest < Test::Unit::TestCase

    def test_when_success_with_nothing_to_chain
        myObject = mock()
        myObject.expects(:method).once.returns(nil)
        myObject.expects(:method_to_be_called).once
        When.success{myObject.method}.then_call{myObject.method_to_be_called}.as_a_chain
    end

    def test_when_not_success_then_method_is_not_called
        myObject = mock()
        myObject.expects(:method).once.raises(Exception, 'Big, awful, evilish, demonic exception')
        myObject.expects(:method_to_be_called).never
        When.success{myObject.method}.then_call{myObject.method_to_be_called}.as_a_chain
    end

    def test_that_parameter_is_chained_when_as_a_chain_is_called
        parameter = 'Highly difficult to calculate value'
        myObject = mock()
        myObject.expects(:method).once.returns(parameter)
        myObject.expects(:method_to_be_called).with(parameter).once
        When.success{myObject.method}.then_call{|x| myObject.method_to_be_called(x)}.as_a_chain
    end

    def test_overload_of_that
        parameter = 'Highly difficult to calculate value'
        myObject = mock()
        myObject.expects(:method).once.returns(parameter)
        myObject.expects(:method_to_be_called).with(parameter).once
        When.success{myObject.method}.then_call(:as_a_chain){|x| myObject.method_to_be_called(x)}
    end

    def test_with_args_with_one_argument
        firstArgument = 'Fixed argument'
        secondArgument = 'Another fixed argument'
        myObject = mock()
        myObject.expects(:method).once
        myObject.expects(:method_to_be_called).with(firstArgument,secondArgument).once
        When.success{myObject.method}.then_call{|x,y| myObject.method_to_be_called(x,y)}.with_args(firstArgument,secondArgument)
    end

 
end
