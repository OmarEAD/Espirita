################
# Definir os dados de entrada
x <- c(1,2,5)
y <- c(0,4,11)

gold <- (1+sqrt(5))/2
gold

# Defina a função de modelo
# O valor 15 é a assintota: 10+4+1
# Mas poderia ser 16, visto que é um potencial,
# ou seja, pode aparecer mais daqueles que recebem 1 talento
# Em outras palavras, 15 talentos ele já tem.
# Para ser potencial, deve ser 16 ou gold*10

model_function <- function(a, x) {
  gold * 10 * (1 - exp(-a * (x-1)))
}

# Ajustar o modelo usando a função nls
fit <- nls(y ~ model_function(a,  x), 
           start = list(a = 0.8))
# Imprima os parâmetros ótimos
coef(fit)

# Gerar previsões para 100 valores de x entre 1 e 10
x_pred <- data.frame(x = seq(from = 1, to = 15, length.out = 200))
y_pred <- predict(fit, x_pred)
# Plot dos dados reais e dos valores previstos
par(mar=c(2.5,2.5,0.5,0.5), mgp=c(1.5,0.5,0))
plot(x, y, col = "blue", pch = 20, cex = 1.5, 
     xlim = c(0,15),ylim = c(0,17),
     xlab = 'Talentos iniciais',
     ylab = 'Talentos finais')
lines(x_pred$x, y_pred, col = "black",lwd=2)
abline(h=16,lty=2,lwd=2,col='blue')
abline(h=8,lty=2,lwd=2,col='green')
abline(v=log(2)/coef(fit) + 1,lty=2,lwd=2,col='green')
# livro do Pinheiro pg 511 (half-life t0.5) 
coef(fit)
log(2)/(coef(fit))
# predizendo o valor de talentos para a meia vida
predict(fit, data.frame(x=c(2.436051 + 1)))
# quanto maior x, mais a predição se aproxima da assintota
# x=50, y=15.99999
predict(fit, data.frame(x=c(50)))
#O que importa aqui, não são os valores, mas sim a função
round(predict(fit, data.frame(x)),2)

##########################################
library(ggplot2)

# cria um vetor com valores de x entre 0 e 5
x <- seq(0, 5, by = 0.1)

# calcula os valores de y para cada valor de x
y <- 16 * (1 - exp(-0.5 * (x - 1)))

# cria um data frame com os valores de x e y
df <- data.frame(x = x, y = y)

# cria o gráfico utilizando ggplot2
ggplot(df, aes(x, y)) +
  geom_line() +
  geom_hline(yintercept = 8, linetype = "dashed") +
  geom_vline(xintercept = 1, linetype = "dashed") +
  labs(x = "x", y = "y") +
  ggtitle("Função y = 16 * (1 - exp(-0.5 * (x-1)))")



(coef(fit)*gold) / ((log(2)/(coef(fit)))/gold)


x2 <- c(1, 2, 5, 17, 28, 43 )
y2 <- c(0, 4, 11, 22, 35,52)
plot(y2~x2)

x <- c(1,2,5)
y <- c(0,4,11)
df <- data.frame(x, y)
par(mar=c(2.5,2.5,0.5,0.5), mgp=c(1.5,0.5,0))
plot(df$x, df$y, col = "blue", pch = 19, 
     xlab = "Eixo X", 
     ylab = "Eixo Y")
modelo <- lm(y ~ x, data = df)
abline(modelo, col = "red")


# https://stackoverflow.com/questions/42306374/fibonnaci-sequence-golden-ratio-in-r
fib=c(1,1)
ratio <- c()
for (i in 3:20) {
  ratio <- c(ratio, fib[i-1]/fib[i-2])
  fib[i] <- fib[i-1]+fib[i-2]
  i=i+1
}
plot(ratio, pch=20,col='blue')
lines(ratio, pch=20,col='green')
abline(h=gold, col='blue')
legend('topright', 
       legend=c('f(i)/f(i+1)', 'Razão Áurea'), 
       col=c('blue', 'blue'), lwd=2)


