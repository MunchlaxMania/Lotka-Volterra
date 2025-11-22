using Plots
const alpha = 3.0 #兎の繁殖率
const beta = 1.0  #食べられやすさ
const gamma = 3.0 #狐の死亡率
const delta = 1.0 #狐の死亡率

const h = 0.1   #時間単位

function rk(u, func)
    k1 = h * func(u)
    k2 = h * func(u + k1/2)
    k3 = h * func(u + k2/2)
    k4 = h * func(u + k3)

    return (k1 + 2*k2 + 2*k3 + k4) / 6
end

function lotka_volterra(u)
    r = u[1]    #兎
    f = u[2]    #狐
    
    dr = alpha * r - beta * r * f
    df = delta * r * f - gamma * f

    return [dr, df]
end

function main()
    #初期値設定
    t0 = 0.0  #時間
    r0 = 50.0   #兎
    f0 = 5.0    #狐

    #配列の作成
    t = [t0]
    r = [r0]
    f = [f0]

    u0 = [r0, f0]

    #プロット
    # p1 = plot(t, r0, leg=false, lc="red", lw=3)
    # p2 = plot(t, f0, leg=false, lc="blue", lw=3)
    # p12 = plot(p1, p2)

    #関数

    while t0 < 30
        du = rk(u0, lotka_volterra)
        u1 = u0 + du
        t1 = t0 + h
        push!(t, t1)
        push!(r, u1[1])
        push!(f, u1[2])
        t0 = t1
        u0 = u1
    end
    plot(t, [r f],
        label=["Rabbit" "Fox"],
        lw = 2,
        xlabel = "Time", ylabel = "Population")
    
    savefig("lotka_volterra.png")
end

main()
