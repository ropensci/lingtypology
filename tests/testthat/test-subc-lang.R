df <- data.frame(my_langs = c("Korean", "Lechitic"), stringsAsFactors = FALSE)

test_that("subc.lang", {
  skip_on_cran()
    expect_equal(subc.lang("Korean"), c(Korean = "((chol1278:1,kyon1247:1)chol1288:1,(chun1247:1,hwan1238:1)chun1248:1,(hamg1238:1,pyon1239:1)hamg1239:1,(earl1249:1,late1258:1)midd1372:1,seou1239:1)kore1280:1;"))
    expect_equal(subc.lang(c("Korean", "Lechitic")), c(Korean = "((chol1278:1,kyon1247:1)chol1288:1,(chun1247:1,hwan1238:1)chun1248:1,(hamg1238:1,pyon1239:1)hamg1239:1,(earl1249:1,late1258:1)midd1372:1,seou1239:1)kore1280:1;",
                                                       Lechitic = "((kash1275:1,slov1270:1)kash1274:1,pola1255:1,((grea1303:1,litt1243:1,oldp1256:1)poli1260:1,sile1253:1)poli1262:1)lech1241:1;"))
    expect_equal(subc.lang(df), c(my_langs1 = "((chol1278:1,kyon1247:1)chol1288:1,(chun1247:1,hwan1238:1)chun1248:1,(hamg1238:1,pyon1239:1)hamg1239:1,(earl1249:1,late1258:1)midd1372:1,seou1239:1)kore1280:1;",
                                 my_langs2 = "((kash1275:1,slov1270:1)kash1274:1,pola1255:1,((grea1303:1,litt1243:1,oldp1256:1)poli1260:1,sile1253:1)poli1262:1)lech1241:1;"))
})
