using CMG.Application.DTO;
using CMG.Application.ViewModel;
using CMG.UI.Controls;
using Microsoft.Win32;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
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
        private void PhotoUploadButton_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog op = new OpenFileDialog();
            op.Title = "Select a picture";
            op.Filter = "All supported graphics|*.jpg;*.jpeg;*.png|" +
              "JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg|" +
              "Portable Network Graphic (*.png)|*.png";
            if (op.ShowDialog() == true)
            {
                PeopleViewModel peopleViewModel = (PeopleViewModel)DataContext;
                if (peopleViewModel != null && peopleViewModel.People != null)
                {
                    peopleViewModel.People.PhotoPath = op.FileName;
                    peopleViewModel.IsPhotoInEditMode = true;
                    peopleViewModel.IsPhotoInSavedMode = false;
                    peopleViewModel.People = peopleViewModel.People;
                }
            }
        }
        #region Helper Methods
        #endregion
    }
}
