class Die
  attr_reader :sides

  def initialize(sides)
    @sides = sides
  end

  def roll
    rand(1..sides)
  end
end

class DiceRoller
  def initialize(dice)
    @dice = dice
  end

  def roll_all
    results = @dice.map(&:roll)
    dice_descriptions = @dice.map { |die| "#{die.sides}-sided die" }
    puts "Rolled #{dice_descriptions.join(', ')}: #{results.join(', ')} (Total: #{results.sum})"
  end
end

die1 = Die.new(6)
die2 = Die.new(8)
die3 = Die.new(4)

DiceRoller.new([die1, die2, die3]).roll_all
