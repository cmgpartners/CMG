using CMG.Application.DTO;
using CMG.Application.ViewModel;
using CMG.UI.Controls;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Threading;

namespace CMG.UI.View
{
    public partial class PeopleView : UserControl
    {
        #region Member variables
        #endregion Member variables
        public PeopleView()
        {
            InitializeComponent();
        }
        private void ButtonSearchSliderClose_Click(object sender, RoutedEventArgs e)
        {
            var timer = new DispatcherTimer { Interval = TimeSpan.FromMilliseconds(450) };
            timer.Start();
            timer.Tick += (sender, args) =>
            {
                timer.Stop();
                SearchSliderColumn.Width = new GridLength(0);
                SearchBar.Visibility = Visibility.Visible;
                searchBarColumn.Width = new GridLength(200);
            };
        }
        private void ButtonSearchSliderOpen_Click(object sender, RoutedEventArgs e)
        {
            SearchBar.Visibility = Visibility.Collapsed;
            SearchSliderColumn.Width = new GridLength(450);
            searchBarColumn.Width = new GridLength(0);
        }

        #region Helper Methods
        #endregion
    }
}
