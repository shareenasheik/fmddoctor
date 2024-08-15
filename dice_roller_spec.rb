require 'rspec'
require_relative './dice_roller'

RSpec.describe Die do
  describe '#initialize' do
    it 'sets the number of sides' do
      die = Die.new(6)
      expect(die.sides).to eq(6)
    end
  end

  describe '#roll' do
    it 'returns a value between 1 and the number of sides' do
      die = Die.new(6)
      roll = die.roll
      expect(roll).to be_between(1, 6).inclusive
    end

    it 'returns random values on multiple rolls' do
      die = Die.new(6)
      rolls = Array.new(100) { die.roll }
      expect(rolls.uniq.length).to be > 1
    end
  end
end


RSpec.describe DiceRoller do
  describe '#initialize' do
    it 'sets up an array of dice' do
      die1 = Die.new(6)
      die2 = Die.new(8)
      dice_roller = DiceRoller.new([die1, die2])
      expect(dice_roller.instance_variable_get(:@dice)).to eq([die1, die2])
    end
  end

  describe '#roll_all' do
    it 'rolls all dice and prints the results' do
      die1 = Die.new(6)
      die2 = Die.new(8)
      die3 = Die.new(4)

      allow(die1).to receive(:roll).and_return(3)
      allow(die2).to receive(:roll).and_return(7)
      allow(die3).to receive(:roll).and_return(2)

      dice_roller = DiceRoller.new([die1, die2, die3])

      expect do
        dice_roller.roll_all
      end.to output("Rolled 6-sided die, 8-sided die, 4-sided die: 3, 7, 2 (Total: 12)\n").to_stdout
    end

    it 'correctly sums the total of all dice rolls' do
      die1 = Die.new(6)
      die2 = Die.new(8)
      die3 = Die.new(4)

      allow(die1).to receive(:roll).and_return(5)
      allow(die2).to receive(:roll).and_return(6)
      allow(die3).to receive(:roll).and_return(3)

      dice_roller = DiceRoller.new([die1, die2, die3])
      expect { dice_roller.roll_all }.to output(/Total: 14/).to_stdout
    end
  end
end
