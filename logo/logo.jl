using Luxor, Random
rng = MersenneTwister(100)
helsinkilogo = Path([
    PathMove(Point(4.245, 57.972)),
    PathCurve(Point(9.725, 52.512), Point(17.013, 49.505), Point(24.763, 49.505)),
    PathLine(Point(102.34, 49.505)),
    PathCurve(Point(120.348, 49.505), Point(135, 35.014), Point(135, 17.203)),
    PathLine(Point(135, -61.799)),
    PathLine(Point(-134.588, -61.799)),
    PathLine(Point(-134.588, 17.203)),
    PathCurve(Point(-134.588, 35.014), Point(-120.027, 49.505), Point(-102.129, 49.505)),
    PathLine(Point(-24.351, 49.505)),
    PathCurve(Point(-16.601, 49.505), Point(-9.315, 52.512), Point(-3.835, 57.971)),
    PathLine(Point(0.206, 62)),
    PathClose()])

function sinecurves(y)
    k = 2.3
    @layer begin
        sinewaves = [Point(k * x, y + 4sin(x / k)) for x in (-(300 / k)):(2π / 60):(300 / k)]
        push!(sinewaves, boxbottomright())
        push!(sinewaves, boxbottomleft())
        poly(sinewaves, :fill, close = true)
    end
end

function _randomhue(rng=MersenneTwister())
    rrand, grand, brand = rand(rng, 3)
    sethue(rrand, grand, brand)
    return (rrand, grand, brand)
end

@svg begin
    background("#F5A3C7") # pinkypurple
    # waves
    @layer begin
        setopacity(0.2)
        for y in 0:10:100
            _randomhue(rng)
            sinecurves(y)
        end
    end
    # helskinki logo as background
    drawpath(helsinkilogo, action = :fill)

    # helskinki logo border
    sethue("#0000BF") # blue
    setline(6)
    drawpath(helsinkilogo, action = :stroke)
    setline(4)
    sethue("#fff") # blue
    drawpath(helsinkilogo, action = :stroke)

    # contents
    bx = BoundingBox(helsinkilogo)
    w, h = boxwidth(bx), boxheight(bx)
    panes = Tiler(w, h, 1, 2)
    @layer begin
        translate(first(panes[1]))
        juliacircles(26)
    end
    @layer begin
        translate(first(panes[2]))
        fontface("Montserrat Bold")  # you need to install this font if you haven't it in your pc
        fontsize(28)
        sethue("#FFE977")
        textwrap("Julia Users Helsinki", 60, O + (-60, -80), leading = 28)
    end
end 300 300 "juh-gh.svg"

# 600 160 "juh.svg" for bigger banner
# 300 160 "juh-logo.svg" for smaller logo in navbar
# 400 160 "jug-og.svg" for open graph and google thumbnail (needs to be manually converted to png, e.g. with inkscape)
