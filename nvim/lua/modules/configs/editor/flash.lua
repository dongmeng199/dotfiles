return function()
	local opts = {
		label = {
			uppercase = false,
			rainbow = {
				enabled = true,
				-- number between 1 and 9
				shade = 5,
			},
		},
		jump = {
			-- clear highlight after jump
			nohlsearch = true,
			autojump = true,
		},
		modes = {
			search = {
				enabled = false,
			},
		},
	}
	return opts
end
