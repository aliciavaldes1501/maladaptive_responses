ggplot()+
  geom_line(data=data.frame(ggpredict(selection_2018,
                                 terms = c("ffd_std[all]","temp[14]"))),
            aes(x=x,y=predicted),color="blue",size=1)+
  geom_line(data=data.frame(ggpredict(selection_2018,
                                 terms = c("ffd_std[all]","temp[21]"))),
            aes(x=x,y=predicted),color="red",size=1)+
  xlab("Standardized FFD")+ylab("Predicted relative fitness")+
  labs(colour="Soil\ntemperature\n(ºC)")
                  
ggplot()+
  geom_line(data=data.frame(ggpredict(selection_2018,
                                      terms = c("ffd_std[all]","temp[all]"))),
            aes(x=x,y=predicted,color=as.numeric(group),group=group),size=1)+
  geom_line(data=data.frame(ggpredict(selection_2018,
                                      terms = c("ffd_std[all]","temp[8]"))),
            aes(x=x,y=predicted,color=as.numeric(group),group=group),color="blue",size=1)+
  geom_line(data=data.frame(ggpredict(selection_2018,
                                      terms = c("ffd_std[all]","temp[27]"))),
            aes(x=x,y=predicted,color=as.numeric(group),group=group),color="red",size=1)+
  geom_line(data=data.frame(ggpredict(selection_2018,
                                      terms = c("ffd_std[all]","temp[14]"))),
            aes(x=x,y=predicted,color=as.numeric(group),group=group),color="black",size=1,linetype="dotted")+
  geom_line(data=data.frame(ggpredict(selection_2018,
                                      terms = c("ffd_std[all]","temp[21]"))),
            aes(x=x,y=predicted,color=as.numeric(group),group=group),color="black",size=1,,linetype="dashed")+
  xlab("Standardized FFD")+ylab("Predicted relative fitness")+
  labs(colour="Soil\ntemperature\n(ºC)")+scale_color_viridis()

as.numeric(coef(lm(predicted~x,data=data.frame(ggpredict(selection_2018,
                                                 terms = c("ffd_std[all]","temp[14]")))))[2])
as.numeric(coef(lm(predicted~x,data=data.frame(ggpredict(selection_2018,
                                              terms = c("ffd_std[all]","temp[21]")))))[2])

df_bytemp<-data.frame(ggpredict(selection_2018,
                                 terms = c("ffd_std[all]","temp[4:34,by=1]")))

selgrads_temp <- tibble(
  group = unique(df_bytemp$group),
  slope = sapply(by(df_bytemp, df_bytemp$group, function(subgroup) {
    model <- lm(predicted ~ x, data = subgroup)
    coef(model)  # Extract all coefficients
    }), `[`, "x")  # Extract the slope coefficient for each group
  )

selgrads_temp

write_csv(selgrads_temp,file="C:/Users/alici/Dropbox/SU/Projects/cerastium_greenhouse/data/clean/selgrads_temp_from_Ecology_paper.csv")

sd_FFD_2018<-data.frame(sd_FFD_2018=sd(subset(data_plants,year==2018)$ffd))
write_csv(sd_FFD_2018,file="C:/Users/alici/Dropbox/SU/Projects/cerastium_greenhouse/data/clean/sd_FFD_2018_from_Ecology_paper.csv")
