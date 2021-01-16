module Carbuncle
  class GUI
    class Viewport < Carbuncle::GUI::Container
      attr_reader :font, :gui

      delegate :dispose, :disposed?, to: :gui

      def initialize(font)
        super(nil)
        @font = font
        @gui = Carbuncle::GUI.new(font)
      end

      def update(dt)
        @gui.update
        super
      end

      def draw
        @gui.draw
      end
    end
  end
end
