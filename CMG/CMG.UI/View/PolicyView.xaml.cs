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
using System.Windows.Threading;

namespace CMG.UI.View
{
    /// <summary>
    /// Interaction logic for PolicyView.xaml
    /// </summary>
    public partial class PolicyView : UserControl
    {
        public PolicyView()
        {
            InitializeComponent();
        }

        private void ButtonClose_Click(object sender, RoutedEventArgs e)
        {
            
            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(450) };
            timer.Start();
            timer.Tick += (sender, args) =>
            {
                timer.Stop();
                SliderColumn.Width = new GridLength(0);
                SearchBar.Visibility = Visibility.Visible;
                searchBarColumn.Width = new GridLength(200);
            };
            
        }

        private void ButtonOpen_Click(object sender, RoutedEventArgs e)
        {
            SearchBar.Visibility = Visibility.Collapsed;
            SliderColumn.Width = new GridLength(450);
            searchBarColumn.Width = new GridLength(0);
        }
    }
}
