
function love.load()
	width, height = 800, 600
	love.window.setMode(width, height)
	articles = {}
	if love.filesystem.isFile("articles.txt") then
		for line in love.filesystem.lines("articles.txt") do
			table.insert(articles,line)
		end
	else
		for line in love.filesystem.lines("articlesBackup.txt") do
			table.insert(articles,line)
		end
	end
	file = love.filesystem.newFile("articles.txt")
	font = love.graphics.newFont("Prisma.ttf",67)
	fontTimer = love.graphics.newFont("Prisma.ttf",225)
	fontName = love.graphics.newFont("Prisma.ttf",30)
	halfTime = love.audio.newSource("half.wav","static")
	oneMin = love.audio.newSource("onemin.wav","static")
	timeUp = love.audio.newSource("timeup.wav","static")
	time = os.date("*t")
	countdown = time.sec
	year70 = 62125920000
	mins = 7
	secs = 0
	hand = love.mouse.getSystemCursor("hand")
	rtime = 139
	gtime = 190
	btime = 178
	rres = 139
	gres = 190
	bres = 178
	rgen = 139
	ggen = 190
	bgen = 178
end

function round(val, decimal)
  if (decimal) then
    return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
  else
    return math.floor(val+0.5)
  end
end

function timeHigh()
	if mx >= 137 and mx <= 676 then
		if my >= 441 and my <= 538 then
			if start or mins == 7 then
				love.mouse.setCursor(hand)
				rtime = 168
				gtime = 230
				btime = 215
				rres = 168
				gres = 230
				bres = 215
			elseif secs == 0 and mins == 0 then
				love.mouse.setCursor(hand)
				rtime = 168
				gtime = 230
				btime = 215
				rres = 168
				gres = 230
				bres = 215
			elseif mx <= 400 then
				love.mouse.setCursor(hand)
				rtime = 168
				gtime = 230
				btime = 215
				rres = 139
				gres = 190
				bres = 178
			else
				love.mouse.setCursor(hand)
				rtime = 139
				gtime = 190
				btime = 178
				rres = 168
				gres = 230
				bres = 215
			end
		else
			love.mouse.setCursor()
			rres = 139
			gres = 190
			bres = 178
			rtime = 139
			gtime = 190
			btime = 178
		end
	else
		love.mouse.setCursor()
		rtime = 139
		gtime = 190
		btime = 178
		rres = 139
		gres = 190
		bres = 178
	end
end

function love.update()
	time = os.date("*t")
	day = (time.year * 365) + time.yday
	hour = (day * 24) + time.hour
	minute = (hour * 60) + time.min
	second = (minute * 60) + time.sec
	seed = second - year70
	mx, my = love.mouse.getPosition()
	if mx >= 137 and mx <= 676 then
		if my >= 85 and my <= 182 then
			love.mouse.setCursor(hand)
			rgen = 168
			ggen = 230
			bgen = 215	
		else
			love.mouse.setCursor()
			rgen = 139
			ggen = 190
			bgen = 178
			timeHigh()
		end
	else
		love.mouse.setCursor()
		rgen = 139
		ggen = 190
		bgen = 178
		timeHigh()
	end

end

function love.mousepressed(x, y, button)
	if x >= 137 and x <= 676 then
		if y >= 85 and y <= 182 then
			math.randomseed(seed)
			topicNum = math.random(1,#articles)
			topic = articles[topicNum]
			table.remove(articles, topicNum)
			love.system.openURL("http://en.wikipedia.org/wiki/"..topic)	
		end
	end

	if x >= 137 and x <= 676 then
		if y >= 441 and y <= 538 then
			if start then
				start = false
			elseif mins == 0 and secs == 0 then
				mins = 7
				secs = 0
				done = false
			elseif mins == 7 then
				start = true
				love.system.openURL("http://en.wikipedia.org/wiki/Special:Random")
			elseif x <= width/2 then
				start = true
			elseif x > width/2 then
				mins = 7
				secs = 0
				done = false
			end
		end
	end
end

function timer()
	if start then
		if countdown ~= time.sec then
			if secs < 1 then
				secs = 59
				mins = mins - 1
			else
				secs = secs - 1
			end
			countdown = time.sec
		end
	end
end

function love.draw()
	timer()
	love.graphics.setBackgroundColor(242,236,188)
	love.graphics.setColor(92,75,81)
	love.graphics.setFont(font)
	love.graphics.print("Wikipedia Game",125, -10)
	love.graphics.setColor(rgen,ggen,bgen)
	love.graphics.rectangle("fill",137,85,539,97)
	love.graphics.setColor(221,157,114)
	love.graphics.print("Generate Topic",150,82)
	love.graphics.setColor(rtime,gtime,btime)
	love.graphics.rectangle("fill",126,441,275,97)
	love.graphics.setColor(rres,gres,bres)
	love.graphics.rectangle("fill",400,441,270,97)
	love.graphics.setColor(221,157,114)
	if start then
		love.graphics.print("Stop Timer",202,437)
	elseif mins == 7 and secs == 0 then
		love.graphics.print("Start Timer",191,437)
	elseif mins == 0 and secs == 0 then
		love.graphics.print("Reset",314,437)
	else
		love.graphics.print("Resume",133,437)
		love.graphics.print("Reset",452,437)
		love.graphics.setColor(242,236,188)
		love.graphics.rectangle("fill",400,441,10,97)
	end
	love.graphics.setColor(242,98,93)
	love.graphics.setFont(fontTimer)
	if secs < 10 then
		pSecs = "0"..secs
	else
		pSecs = secs
	end
	love.graphics.print(mins..":"..pSecs,145,145)
	love.graphics.setFont(fontName)
	love.graphics.print("Bonspiel1",650,555)
	if mins == 0 and secs == 0 then
		start = false
	end
	if mins == 3 and secs == 30 then
		love.audio.play(halfTime)
	elseif mins == 1 and secs == 0 then
		love.audio.play(oneMin)
	elseif mins == 0 and secs == 0 then
		if done == false or done == nil then
			love.audio.play(timeUp)
			done = true
		end
	end
end

function love.quit()
	love.filesystem.write("articles.txt",articles[1])
	file:open('a')
	for l = 2, #articles do
		file:write("\n"..articles[l])
	end
end
