manhplot <- ggplot(gravier_data_long_nested, 
                   mapping = aes(x = reorder(gene, desc(neg_log10_p)), 
                                 y = neg_log10_p, 
                                 color = identified_as)) +
  geom_point(alpha = 0.75, size = 2) +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed") + 
  labs(x = "Gene", 
       y = "Minus log 10(p)") + 
  theme_classic(base_family = "Avenir", base_size = 8) +
  theme( 
    legend.position = "bottom",
    panel.border = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    axis.text.x = element_text(angle = 45, size = 4, vjust = 0.5)
  )