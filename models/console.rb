require_relative('bounty_hunters.rb')

bounty1 = Bounties.new({name: "Junkrat", species: "rat/human", favourite_weapon: "riptire", bounty_value: 2000 })

bounty1.save
# Bounties.delete_all
# bounty1.print
bounty1.bounty_value = 10000
bounty1.update
# bounty1.print
# bounty1.print
Bounties.find_bounty('Junkrat')
p '-----------'

Bounties.all