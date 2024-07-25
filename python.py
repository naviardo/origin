import os

def get_size(start_path='.'):
    total_size = 0
    if os.path.isfile(start_path):
        total_size = os.path.getsize(start_path)
    else:
        for dirpath, dirnames, filenames in os.walk(start_path):
            for f in filenames:
                fp = os.path.join(dirpath, f)
                total_size += os.path.getsize(fp)
    return total_size

def analyze_directory(start_path='.'):
    items = []
    for item in os.listdir(start_path):
        item_path = os.path.join(start_path, item)
        item_size = get_size(item_path)
        items.append((item, item_size))
    return items

def display_results(results, page_size=10):
    total_pages = (len(results) + page_size - 1) // page_size
    for page in range(total_pages):
        start = page * page_size
        end = start + page_size
        page_results = results[start:end]
        
        for item, size in page_results:
            print(f"{item}: {size} bytes")
        
        if page < total_pages - 1:
            input("Нажмите Enter для отображения следующей страницы...")

# Выполнение анализа и сортировки
results = analyze_directory()
sorted_results = sorted(results, key=lambda x: x[1], reverse=True)

# Вывод результатов в терминал
display_results(sorted_results)
