using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace CMG.UI.View
{
    /// <summary>
    /// Interaction logic for ConfigurationView.xaml
    /// </summary>
    public partial class ConfigurationView : UserControl
    {
        public ConfigurationView()
        {
            InitializeComponent();
        }

        private void CompanyAdd_Click(object sender, RoutedEventArgs e)
        {
            if (companies.Items.Count > 1)
            {
                var lastRowItem = companies.Items[companies.Items.Count - 1];
                companies.ScrollIntoView(lastRowItem);
            }
        }

        private void StatusAdd_Click(object sender, RoutedEventArgs e)
        {
            if (status.Items.Count > 1)
            {
                var lastRowItem = status.Items[status.Items.Count - 1];
                status.ScrollIntoView(lastRowItem);
            }
        }
    }
}
