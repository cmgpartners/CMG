using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace CMG.UI.Controls
{
    /// <summary>
    /// Interaction logic for AutoCompleteBox.xaml
    /// </summary>
    public partial class AutoCompleteBox : UserControl
    {
        public AutoCompleteBox()
        {
            InitializeComponent();
        }
        #region Properties
        public static readonly DependencyProperty autoSuggestionList = DependencyProperty.Register("AutoSuggestionList", typeof(List<string>), typeof(AutoCompleteBox));
        public List<string> AutoSuggestionList
        {
            get { return (List<string>)this.GetValue(autoSuggestionList); }
            set { this.SetValue(autoSuggestionList, value); }
        }

        public static readonly DependencyProperty selectedValue = DependencyProperty.Register("SelectedValue", typeof(string), typeof(AutoCompleteBox), new FrameworkPropertyMetadata(OnAvailableItemsChanged)
        {
            BindsTwoWayByDefault = true
        });
        public string SelectedValue
        {
            get { return (string)this.GetValue(selectedValue); }
            set { this.SetValue(selectedValue, value); }
        }
        #endregion Properties

        #region Methods
        private void OpenAutoSuggestionBox()
        {
            try
            {
                // Enable.
                this.autoListPopup.Visibility = Visibility.Visible;
                this.autoListPopup.IsOpen = true;
                this.autoList.Visibility = Visibility.Visible;
            }
            catch (Exception ex)
            {
                // Info.
                MessageBox.Show(ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                Console.Write(ex);
            }
        }
        private void CloseAutoSuggestionBox()
        {
            try
            {
                // Enable.
                this.autoListPopup.Visibility = Visibility.Collapsed;
                this.autoListPopup.IsOpen = false;
                this.autoList.Visibility = Visibility.Collapsed;
            }
            catch (Exception ex)
            {
                // Info.
                MessageBox.Show(ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                Console.Write(ex);
            }
        }
        #endregion Methods

        #region Events
        private void AutoTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            try
            {
                this.SelectedValue = this.autoTextBox.Text.Trim();
                if (string.IsNullOrEmpty(this.autoTextBox.Text))
                {
                    this.CloseAutoSuggestionBox();

                    return;
                }
                if(!this.AutoSuggestionList.Any(a => a == SelectedValue))
                    this.OpenAutoSuggestionBox();
                this.autoList.ItemsSource = this.AutoSuggestionList.Where(p => p.ToLower().StartsWith(this.autoTextBox.Text.ToLower())).ToList();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                Console.Write(ex);
            }
        }
        private void AutoList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                // Verification.
                if (this.autoList.SelectedIndex <= -1)
                {
                    // Disable.
                    this.CloseAutoSuggestionBox();

                    // Info.
                    return;
                }

                // Disable.
                this.CloseAutoSuggestionBox();

                // Settings.
                this.autoTextBox.Text = this.autoList.SelectedItem.ToString();
                this.autoList.SelectedIndex = -1;
            }
            catch (Exception ex)
            {
                // Info.
                MessageBox.Show(ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                Console.Write(ex);
            }
        }
        public static void OnAvailableItemsChanged(
           DependencyObject sender,
           DependencyPropertyChangedEventArgs e)
        {
            // Breakpoint here to see if the new value is being set
            var newValue = e.NewValue;
            //Debugger.Break();
        }
        #endregion Events
    }
}
