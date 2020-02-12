using CMG.Application.ViewModel;
using System;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Threading;
using CMG.Application.DTO;
using CMG.UI.Controls;
using System.Linq;
using System.Collections.ObjectModel;
using System.Collections.Generic;
using System.IO;
using System.Diagnostics;
using MaterialDesignThemes.Wpf;

namespace CMG.UI.View
{
    /// <summary>
    /// Interaction logic for FileManagerView.xaml
    /// </summary>
    public partial class FileManagerView : UserControl
    {
        #region Member variables
        private DragAdorner _adorner;
        private AdornerLayer _layer;
        private Point startPoint;
        private FileManagerViewModel fileManagerViewModel;
        #endregion Member variables

        #region Constructor
        public FileManagerView()
        {
            InitializeComponent();
            Dispatcher.BeginInvoke(DispatcherPriority.Loaded, new Action(() =>
            {
                InitializeViewModel();
                if(fileManagerViewModel.SelectedClient != null)
                {
                    FolderView.Items.Clear();
                    BindDefaultTreeViewItem("I:\\", "I:\\");
                    SelectClientFolder("I:\\");
                }
            }));
        }
        #endregion Constructor

        #region Events
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
        private void EntityTypePanel_Loaded(object sender, RoutedEventArgs e)
        {
            WrapPanel entityTypePanel = (WrapPanel)sender;
            var entityTypeAutoComplete = entityTypePanel.Children.Count > 0 ? (AutoCompleteBox)entityTypePanel.Children[1] : null;
            if (entityTypeAutoComplete != null)
            {
                if (fileManagerViewModel != null
                    && !string.IsNullOrEmpty(fileManagerViewModel.EntityType))
                {
                    entityTypeAutoComplete.autoTextBox.Text = fileManagerViewModel.EntityType;
                }
            }
        }
        private void PolicyNumberPanel_Loaded(object sender, RoutedEventArgs e)
        {
            WrapPanel policyNumberPanel = (WrapPanel)sender;
            var policyNumberAutoComplete = policyNumberPanel.Children.Count > 0 ? (AutoCompleteBox)policyNumberPanel.Children[1] : null;
            if (policyNumberAutoComplete != null)
            {
                if (fileManagerViewModel != null
                    && !string.IsNullOrEmpty(fileManagerViewModel.PolicyNumber))
                {
                    policyNumberAutoComplete.autoTextBox.Text = fileManagerViewModel.PolicyNumber;
                }
            }
        }
        private void CompanyNamePanel_Loaded(object sender, RoutedEventArgs e)
        {
            WrapPanel companyNamePanel = (WrapPanel)sender;
            var companyNameAutoComplete = companyNamePanel.Children.Count > 0 ? (AutoCompleteBox)companyNamePanel.Children[1] : null;
            if (companyNameAutoComplete != null)
            {
                if (fileManagerViewModel != null
                    && !string.IsNullOrEmpty(fileManagerViewModel.CompanyName))
                {
                    companyNameAutoComplete.autoTextBox.Text = fileManagerViewModel.CompanyName;
                }
            }
        }
        private void SearchOptionsList_PreviewMouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            startPoint = e.GetPosition(null);
        }
        private void SearchOptionsList_PreviewMouseMove(object sender, MouseEventArgs e)
        {
            if (e.LeftButton == MouseButtonState.Pressed)
            {
                Point position = e.GetPosition(null);

                if (Math.Abs(position.X - startPoint.X) > SystemParameters.MinimumHorizontalDragDistance ||
                    Math.Abs(position.Y - startPoint.Y) > SystemParameters.MinimumVerticalDragDistance)
                {
                    BeginDrag(e);
                }
            }
        }
        private void SearchOptionsList_Drop(object sender, DragEventArgs e)
        {
            try
            {
                fileManagerViewModel = (FileManagerViewModel)this.DataContext;
                ListView searchOptionsListView = (ListView)sender;
                ViewSearchOptionsDto droppedData = (ViewSearchOptionsDto)FindAnchestor<ListViewItem>((DependencyObject)e.OriginalSource)?.DataContext;
                ViewSearchOptionsDto draggedData = (ViewSearchOptionsDto)searchOptionsListView.SelectedItem;

                var droppedDataIndex = searchOptionsListView.Items.IndexOf(droppedData);
                var draggedDataIndex = searchOptionsListView.Items.IndexOf(draggedData);

                if (draggedDataIndex >= 0 && droppedDataIndex >= 0)
                {
                    if (draggedDataIndex > droppedDataIndex)
                    {
                        for (var i = droppedDataIndex; i < draggedDataIndex; i++)
                        {
                            fileManagerViewModel.SearchOptions[i].ColumnOrder = i + 1;
                        }
                        fileManagerViewModel.SearchOptions.Where(s => s.ColumnName == draggedData.ColumnName).Select(o => { o.ColumnOrder = droppedDataIndex; return o; }).ToList();
                        fileManagerViewModel.SearchOptions = new ObservableCollection<ViewSearchOptionsDto>(fileManagerViewModel.SearchOptions.OrderBy(c => c.ColumnOrder).ToList());
                    }
                    else if (droppedDataIndex > draggedDataIndex)
                    {
                        for (var i = droppedDataIndex; i > draggedDataIndex; i--)
                        {
                            fileManagerViewModel.SearchOptions[i].ColumnOrder = i - 1;
                        }
                        fileManagerViewModel.SearchOptions.Where(s => s.ColumnName == draggedData.ColumnName).Select(o => { o.ColumnOrder = droppedDataIndex; return o; }).ToList();
                        fileManagerViewModel.SearchOptions = new ObservableCollection<ViewSearchOptionsDto>(fileManagerViewModel.SearchOptions.OrderBy(c => c.ColumnOrder).ToList());
                    }
                    fileManagerViewModel.SaveSearchOptions();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        private static T FindAnchestor<T>(DependencyObject current)
        where T : DependencyObject
        {
            do
            {
                if (current is T)
                {
                    return (T)current;
                }
                current = VisualTreeHelper.GetParent(current);
            }
            while (current != null);
            return null;
        }
        private void InitialiseAdorner(ListViewItem listViewItem)
        {
            VisualBrush brush = new VisualBrush(listViewItem);
            _adorner = new DragAdorner((UIElement)listViewItem, listViewItem.RenderSize, brush);
            _adorner.Opacity = 0.5;
            _layer = AdornerLayer.GetAdornerLayer(SearchOptionsList as Visual);
            _layer.Add(_adorner);
        }
        private void BeginDrag(MouseEventArgs e)
        {
            ListView searchOptionsListView = SearchOptionsList;
            ListViewItem listViewItem = FindAnchestor<ListViewItem>((DependencyObject)e.OriginalSource);
            if (listViewItem == null)
                return;

            var currentColumn = searchOptionsListView.ItemContainerGenerator.ItemFromContainer(listViewItem);
            //setup the drag adorner.
            InitialiseAdorner(listViewItem);
            DataObject data = new DataObject(currentColumn);
            if (_adorner != null)
            {
                AdornerLayer.GetAdornerLayer(searchOptionsListView).Remove(_adorner);
                _adorner = null;
            }
        }
        private void UserControl_Loaded(object sender, RoutedEventArgs e)
        {
            Button btnDrive;
            TextBlock nestedTxtBlock;
            StackPanel nestedStackPanel;

            InitializeViewModel();
            if (fileManagerViewModel != null)
            {
                for (int i = 0; i < fileManagerViewModel.MappedDrives.Count; i++)
                {
                    btnDrive = new Button();
                    btnDrive.Background = (SolidColorBrush)new BrushConverter().ConvertFrom("White");
                    btnDrive.Margin = new Thickness(10, 0, 0, 0);
                    btnDrive.BorderThickness = new Thickness(0, 0, 0, 3);
                    btnDrive.Click += BtnDrive_Click;
                    nestedTxtBlock = new TextBlock();
                    nestedTxtBlock.Name = "txtBlock";
                    nestedTxtBlock.Text = " " + fileManagerViewModel.MappedDrives[i].Name;
                    nestedTxtBlock.Foreground = (SolidColorBrush)new BrushConverter().ConvertFrom("Black");
                    nestedStackPanel = new StackPanel();
                    nestedStackPanel.Orientation = Orientation.Horizontal;
                    nestedStackPanel.Children.Add(new MaterialDesignThemes.Wpf.PackIcon
                                                    { Kind = MaterialDesignThemes.Wpf.PackIconKind.Computer, 
                                                      Foreground = (SolidColorBrush)new BrushConverter().ConvertFrom("Black")
                                                    });
                    nestedStackPanel.Children.Add(nestedTxtBlock);
                    btnDrive.Content = nestedStackPanel;
                    spDrives.Children.Add(btnDrive);
                }
            }

       }
        private void BtnDrive_Click(object sender, RoutedEventArgs e)
        {
            FolderView.Items.Clear();
            Button button = (Button)sender;
            StackPanel stackPanel = (StackPanel)button.Content;
            TextBlock txtBlock = (TextBlock)stackPanel.Children[1];

            BindDefaultTreeViewItem(txtBlock.Text, txtBlock.Text);
            BindFilesToListControl(txtBlock.Text.Trim());
            SelectClientFolder(txtBlock.Text.Trim());
        }
        private void Item_Expanded(object sender, RoutedEventArgs e)
        {
            TreeViewItem item = (TreeViewItem)sender;
            BindTreeviewItems(item);
        }
        private void Search_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            FolderView.Items.Clear();
            BindDefaultTreeViewItem("I:\\", "I:\\");
            InitializeViewModel();
            if (fileManagerViewModel != null)
            {
                SelectClientFolder("I:\\");
            }
        }        
        private void lstFiles_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            StackPanel stackPanel = (StackPanel)((ListView)sender).SelectedItem;

            string path = ((TextBlock)stackPanel.Children[2]).Text;
            // Open file
            Process.Start("explorer.exe", path);
        }
        private void FolderView_SelectedItemChanged(object sender, RoutedPropertyChangedEventArgs<object> e)
        {
            TreeViewItem tvi = (TreeViewItem)((TreeView)sender).SelectedItem;
            if (tvi != null)
            {
                BindFilesToListControl(tvi.Tag.ToString());
            }
        }
        #endregion Events

        #region Methods
        private void InitializeViewModel()
        {
            if (fileManagerViewModel == null
                && (FileManagerViewModel)this.DataContext != null)
            {
                fileManagerViewModel = (FileManagerViewModel)this.DataContext;
            }
        }
        private void BindDefaultTreeViewItem(string itemHeader, string itemTag)
        {
            TreeViewItem item = new TreeViewItem()
            {
                Header = itemHeader,
                Tag = itemTag,
                IsExpanded = true
            };
            item.Expanded += Item_Expanded;
            item.Items.Add(null);
            FolderView.Items.Add(item);
            BindTreeviewItems((TreeViewItem)FolderView.Items[0]);
        }
        private void BindFilesToListControl(string path)
        {
            lstFiles.Items.Clear();
            string[] files = Directory.GetFiles(path.Trim());
            string fileExtension;
            foreach (var file in files)
            {
                TextBlock txtFileName = new TextBlock();
                TextBlock txtFilePath = new TextBlock();
                txtFilePath.Visibility = Visibility.Collapsed;

                txtFileName.Text = new DirectoryInfo(file).Name;
                txtFileName.Padding = new Thickness(5, 0, 0, 0);
                txtFilePath.Text = file;
                fileExtension = new FileInfo(file).Extension.ToLower().Trim();

                StackPanel stackPanel = new StackPanel();
                stackPanel.Orientation = Orientation.Horizontal;

                PackIcon packIcon = new PackIcon();
                packIcon.Foreground = (SolidColorBrush)new BrushConverter().ConvertFrom("Black");

                if (fileExtension == ".docx"
                    || fileExtension == ".doc"
                    || fileExtension == ".docm"
                    || fileExtension == ".dotx"
                    || fileExtension == ".dotm"
                    || fileExtension == ".docb")
                {
                    packIcon.Kind = PackIconKind.FileWord;                    
                }
                else if (fileExtension == ".xlsx"
                        || fileExtension == ".xls"
                        || fileExtension == ".xlsm"
                        || fileExtension == ".xltx"
                        || fileExtension == ".xltm")
                {
                    packIcon.Kind = PackIconKind.FileExcel;
                }
                else if (fileExtension == ".pdf"
                        || fileExtension == ".ps"
                        || fileExtension == ".eps")
                {
                    packIcon.Kind = PackIconKind.FilePdf;
                }

                else if (fileExtension == ".html"
                        || fileExtension == ".htm")
                {
                    packIcon.Kind = PackIconKind.InternetExplorer;
                }
                else if (fileExtension == ".txt")
                {
                    packIcon.Kind = PackIconKind.NoteText;
                }
                else
                {
                    packIcon.Kind = PackIconKind.File;                    
                }
                stackPanel.Children.Add(packIcon);
                stackPanel.Children.Add(txtFileName);
                stackPanel.Children.Add(txtFilePath);
                lstFiles.Items.Add(stackPanel);
            }
        }
        private void SelectClientFolder(string driveName)
        {
            if (fileManagerViewModel.SelectedClient != null)
            {
                var firstName = fileManagerViewModel.SelectedClient.FirstName.Substring(0, 3);
                var path = driveName + fileManagerViewModel.SelectedClient.LastName.Substring(0, 1) + "\\" + fileManagerViewModel.SelectedClient.LastName + "." + firstName;

                if ((TreeViewItem)FolderView.Items[0] != null)
                {
                    TreeViewItem treeViewItem = (TreeViewItem)FolderView.Items[0];
                    foreach (TreeViewItem item in treeViewItem.Items)
                    {
                        if (item.Tag.ToString().Trim() == driveName + fileManagerViewModel.SelectedClient.LastName.Substring(0, 1).Trim())
                        {
                            item.IsExpanded = true;
                            item.IsSelected = true;
                            BindTreeviewItems(item);
                            if (item.Items.Count > 0)
                            {
                                TreeViewItem nestedItem = item;
                                foreach (TreeViewItem nested in nestedItem.Items)
                                {
                                    if (nested.Tag.ToString().Trim() == path)
                                    {
                                        nested.IsExpanded = true;
                                        nested.IsSelected = true;
                                        BindTreeviewItems(nested);
                                        BindFilesToListControl(nested.Tag.ToString());
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        private void BindTreeviewItems(TreeViewItem item)
        {
            if (item.Items.Count != 1 || item.Items[0] != null)
                return;
            item.Items.Clear();

            var driveName = (string)item.Tag;
            var directories = new List<String>();
            try
            {
                string[] dirs = Directory.GetDirectories(driveName.Trim());
                if (dirs.Length > 0)
                foreach (var directory in dirs)
                {
                    DirectoryInfo info = new DirectoryInfo(directory.ToString());
                    if (!info.Attributes.HasFlag(FileAttributes.Hidden))
                        directories.Add(directory);
                }
            }
            catch
            {
                throw new Exception();
            }

            directories.ForEach(directoryPath =>
            {
                var subItem = new TreeViewItem()
                {
                    Header = new DirectoryInfo(directoryPath).Name,
                    Tag = directoryPath
                };

                subItem.Items.Add(null);
                subItem.Expanded += Item_Expanded;
                item.Items.Add(subItem);
            });
        }
        #endregion Methods
    }
}
