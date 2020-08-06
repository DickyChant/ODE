# Lagrangian
$$
T = \frac{1}{2}(m_1+m_2)l_1^2\dot{\theta}_1^2+\frac{1}{2}m_2l_2^2\dot{\theta}_2^2+m_2l_1l_2\dot{\theta}_1\dot{\theta}_2\cos(\theta_1-\theta_2)
$$

$$
V = -(m_1+m_2)gl_1\cos{\theta_1}-m_2gl_2\cos{\theta_2}
$$

$$
L = T-V
$$

$$
(m_1+m_2)l_1^2\ddot{\theta}_1+m_2l_1l_2\ddot{\theta}_2\cos(\theta_1-\theta_2)-m_2l_1l_2\dot{\theta}_1\dot{\theta}_2\sin(\theta_1-\theta_2)+m_2l_1l_2\dot{\theta}_2^2\sin(\theta_1-\theta_2)\\=-m_2l_1l_2\dot{\theta}_1\dot{\theta}_2\sin{(\theta_1-\theta_2)}-(m_1+m_2)gl_1\sin{\theta_1}
$$

$$
m_2l_2^2\ddot{\theta}_2 + m_2l_1l_2\ddot{\theta}_1\cos(\theta_1-\theta_2)+m_2l_1l_2\dot{\theta}_1\dot{\theta}_2\sin{(\theta_1-\theta_2)}-m_2l_1l_2\dot{\theta}_1^2\sin(\theta_1-\theta_2)
\\=m_2l_1l_2\dot{\theta}_1\dot{\theta}_2\sin{(\theta_1-\theta_2)}-m_2gl_2\sin{\theta_2}
$$

$$
\ddot{\theta}_1=-\frac{g(m_1+m_2)\sin{\theta_1}+\cos{(\theta_1-\theta_2)}\dot{\theta}_1^2l_1m_2\sin{(\theta_1-\theta_2)}+\dot{\theta}_2^2l_2m_2\sin(\theta_1-\theta_2)-\cos(\theta_1-\theta_2)gm_2\sin{\theta_2}}{l_1(m_1+m_2\sin^2(\theta_1-\theta_2))}
$$

$$
\ddot{\theta}_2=\frac{\cos(\theta_1-\theta_2)g(m_1+m_2)\sin{\theta_1}+\dot{\theta}_1^2l_1(m_1+m_2)\sin(\theta_1-\theta_2)+\cos{(\theta_1-\theta_2)}\dot{\theta}_2^2l_2m_2\sin{(\theta_1-\theta_2)}-g\sin{\theta_2}(m_1+m_2)}{l_2(m_1+m_2\sin^2(\theta_1-\theta_2))}
$$

$$
\frac{\dot{\theta}_1^{n+1}-\dot{\theta}_1^{n-1}}{2\Delta t}=1^{st}(\theta_1^{n},\theta_2^{n})
$$