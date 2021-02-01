function norm(maxa, maxb, v) {
    return int((v * maxb) / maxa)
}

function rep(c, n, _s) {
    if (n < 1) return ""
    _s = sprintf("%*s", n, "")
    gsub(/./, c, _s)
    return _s
}

function show(_x,_l,_s,_w,_d){
    if (NOCLEAR==0)
        printf("%c[2J%c[H", 27, 27)
    else print rep("-", COLUMNS)
 
    _l = length(i2t)
    for (_x=1; _x<=_l; _x++){
        f = i2t[_x]
        _s = sprintf("%i/%i", data[f], hi[f])
        if (f in p) {
            _d = p[f] - data[f]
        } else _d = 0
        _s = _s " " (_d<0?"":"+") _d
        _w = COLUMNS - (width + 3 + length(_s)) # 
        printf("%*s| %s%s%s %s\n", \
            width, f, \
            rep("#", norm(max, _w, data[f])), \
            rep(".", norm(max, _w, hi[f]-data[f])), \
            "|", \
            _s \
            )
    }
}

BEGIN {
    COLUMNS = ("COLUMNS" in ENVIRON ? int(ENVIRON["COLUMNS"]) : 80)-1
    width = min = 0
    max = 1
}

{
    if ($0 == MARK){
        show()
        for (k in data) p[k] = data[k]
        delete data
    } else {
        f = $NF
        if (length(f) > width) width = length(f)
        c = ++data[f]
        if (c > max) max = c
        if (c < min) min = c
        if (!(f in hi) || hi[f] < c) hi[f] = c
        if (!(f in t2i)) i2t[t2i[f] = ++i] = f
    }
}
