##
# Core Ext - Rspec

module RSpec
  def self.descrivi(*args, &block)
    describe *args, &block
  end

  ##
  # Core
  module Core
    class ExampleGroup
      define_example_group_method     :contesto

      def classe_descritta
        described_class
      end

      def risposta(*args, &block)
        last_response *args, &block
      end
    end

    module Hooks
      alias       :prima              :before
      alias       :dopo               :after
    end

    module MemoizedHelpers
      module ClassMethods
        alias     :sia                :let
        alias     :sia!               :let!
        alias     :soggetto           :subject
        alias     :soggetto!          :subject!
      end
    end
  end

  ##
  # Expectations
  module Expectations
    class ExpectationTarget
      module InstanceMethods
        def che(*args, &block)
          to *args, &block
        end

        def che_non(*args, &block)
          not_to *args, &block
        end
      end
    end
  end

  ##
  # Mocks
  module Mocks
    module ExampleMethods
      alias     :imita              :instance_double
      alias     :imita_classe       :class_double
    end

    class TargetBase
      def che(*args)
        to *args
      end
      def che_non(*args)
        not_to *args
      end

      private

        def matcher_allowed?(matcher)
          matcher.class.name.start_with?("RSpec::Mocks::Matchers".freeze) or
          matcher.class.name.start_with?("RSpec::Matchers::AliasedMatcher".freeze)
        end
    end

    class MessageExpectation
      alias     :e_ritorni          :and_return
    end

    class VerifyingMessageExpectation
      alias     :con                :with
      alias     :esattamente        :exactly
      alias     :volte              :times
      alias     :volta              :times
    end

    module Matchers
      class Receive
        alias   :con                :with
        alias   :esattamente        :exactly
        alias   :volte              :times
        alias   :volta              :times
      end
    end
  end
end

RSpec.configure do |config|
  RSpec::Matchers.alias_matcher :sia,               :be
  RSpec::Matchers.alias_matcher :equivalga_a,       :eq
  RSpec::Matchers.alias_matcher :alzi_errore,       :raise_error
  RSpec::Matchers.alias_matcher :riceva,            :receive
  RSpec::Matchers.alias_matcher :abbia_ricevuto,    :have_received

  config.alias_example_to :esso
  config.alias_example_to :essa

  config.before :each do
    alias         :verifica           :expect
    alias         :consenti           :allow
  end
end