RSpec.describe Conways do
  it "Any live cell with fewer than two live neighbors dies, as if by under population." do
    g = Game.new([
      [1,0,0],
      [0,1,0],
      [0,0,0],
    ])

    expect(g.will_live?(1,1)).to be false
  end

  it "Any live cell with two live neighbors lives on to the next generation." do
    g = Game.new([
      [0,1,0],
      [0,1,1],
      [0,0,0],
    ])

    expect(g.will_live?(1,1)).to be true
  end

  it "Any live cell with three live neighbors lives on to the next generation." do
    g = Game.new([
      [0,1,0],
      [1,1,1],
      [0,0,0],
    ])

    expect(g.will_live?(1,1)).to be true
  end

  it "Any live cell with more than three live neighbors dies, as if by overpopulation." do
    g = Game.new([
      [1,0,1],
      [0,1,0],
      [1,0,1],
    ])

    expect(g.will_live?(1,1)).to be false
  end

  it "Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction." do
    g = Game.new([
      [0,0,0],
      [0,0,0],
      [1,1,1],
    ])

    expect(g.will_live?(1,1)).to be true
  end

  it "Calculates next generation" do
    g = Game.new([
      [1,0,0],
      [0,0,0],
      [1,0,1],
    ])

    expect(g.next_gen).to eq [
      [0,0,0],
      [0,1,0],
      [0,0,0],
    ]
  end
end
