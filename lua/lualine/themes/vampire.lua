local vampire = require("vampire")
local P = vampire.pallete
local _ = vampire.conform

return {
  normal = {
    a = _ { f = P.black, b = P.hot },
    b = _ { f = P.hot, b = P.cold },
    c = _ { f = P.hot, b = P.cold },
  },
  inactive = {
    a = _ { f = P.hot, b = P.cold },
    b = _ { f = P.hot, b = P.cold },
    c = _ { f = P.hot, b = P.cold },
  }
}
