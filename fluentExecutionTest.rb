require 'test/unit'
require 'mocha'

class When
    attr_accessor :precondition
    attr_accessor :precondition_result
    @parameters_must_be_chained = false
    attr_accessor :parameters

    def self.success(&block)
        instance = When.new
        instance.precondition = block
        return instance
    end

    def then(&block)
        @block_to_call = block
        return self
    end

    def precondition_is_executed_successfuly
        begin
            @precondition_result = @precondition.call
            return true
        rescue Exception
            return false
        end
    end

    def as_a_chain
        if precondition_is_executed_successfuly
            @block_to_call.call @precondition_result
        end
    end
end

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
