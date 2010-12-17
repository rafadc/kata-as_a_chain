require 'test/unit'
require 'mocha'
require 'when'

class FluentExecutionAPITest < Test::Unit::TestCase

    def test_when_success_then_simple_combination
        myObject = mock()
        myObject.expects(:method).once.returns('Useless value')
        myObject.expects(:method_to_be_called).once
        When.success{myObject.method}.then{myObject.method_to_be_called}.as_a_chain
    end

    def test_when_not_success_then_method_is_not_called
        myObject = mock()
        myObject.expects(:method).once.raises(Exception, 'Big, awful, evilish, demonic exception')
        myObject.expects(:method_to_be_called).never
        When.success{myObject.method}.then{myObject.method_to_be_called}.as_a_chain
    end

    def test_that_parameter_is_chained_when_as_a_chain_is_called
        parameter = 'Highly difficult to calculate value'
        myObject = mock()
        myObject.expects(:method).once.returns(parameter)
        myObject.expects(:method_to_be_called).with(parameter).once
        When.success{myObject.method}.then{|x| myObject.method_to_be_called(x)}.as_a_chain
    end

 

end
