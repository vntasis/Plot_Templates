# gg3D is required for 3D plotting with ggplot
library(gg3D)

# theta: rotation parameter
# phi: tilt parameter
theta <- 0
phi <- 20

ggplot(data, aes(x, y, z, color=group)) +
  axes_3D(theta=theta, phi=phi) +
  stat_3D(theta=theta, phi=phi) +
  axis_labs_3D(theta=theta, phi=phi, size=3,
               hjust=c(1,1,1.2,1.2,1.2,1.2),
               vjust=c(-.5,-.5,-.2,-.2,1.2,1.2)) +
  labs_3D(theta=theta, phi=phi,
          hjust=c(1,0,0), vjust=c(1.5,1,-.2),
          labs=c("X axis", "Y axis", "Z axis")) +
  theme_void()
