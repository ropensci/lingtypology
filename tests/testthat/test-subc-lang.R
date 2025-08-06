df <- data.frame(my_langs = c("Korean", "Lechitic"), stringsAsFactors = FALSE)

test_that("subc.lang", {
  skip_on_cran()
    expect_equal(subc.lang("Korean"), c(Korean = "((Jollado:1,Kyongsangdo:1)chol1288:1,(Ch'ungch'ongdo:1,Hwanghaedo:1)chun1248:1,(Hamgyongdo:1,P'yong'ando:1)hamg1239:1,(Early_Middle_Korean:1,Late_Middle_Korean:1)midd1372:1,Seoul:1)kore1280:1;"))
    expect_equal(subc.lang(c("Korean", "Lechitic")), c(Korean = "((Jollado:1,Kyongsangdo:1)chol1288:1,(Ch'ungch'ongdo:1,Hwanghaedo:1)chun1248:1,(Hamgyongdo:1,P'yong'ando:1)hamg1239:1,(Early_Middle_Korean:1,Late_Middle_Korean:1)midd1372:1,Seoul:1)kore1280:1;",
                                                       Lechitic = "((Kashubian_Proper:1,Slovincian:1)kash1274:1,Polabian:1,((Great_Poland:1,Little_Poland:1,Old_Polish:1)poli1260:1,Silesian:1)poli1262:1)lech1241:1;"))
    expect_equal(subc.lang(df), c(my_langs1 = "((Jollado:1,Kyongsangdo:1)chol1288:1,(Ch'ungch'ongdo:1,Hwanghaedo:1)chun1248:1,(Hamgyongdo:1,P'yong'ando:1)hamg1239:1,(Early_Middle_Korean:1,Late_Middle_Korean:1)midd1372:1,Seoul:1)kore1280:1;",
                                 my_langs2 = "((Kashubian_Proper:1,Slovincian:1)kash1274:1,Polabian:1,((Great_Poland:1,Little_Poland:1,Old_Polish:1)poli1260:1,Silesian:1)poli1262:1)lech1241:1;"))
})
