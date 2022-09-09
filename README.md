# ict-hack-4

Борисов Матвей: [Транзакция](https://statemine.subscan.io/extrinsic/2163986-2)

Варгина Алена: [Транзакция](https://statemine.subscan.io/extrinsic/2163972-2)

## Описание

Приложение личный дневник с автоматическим анализом психологических проблем. Цель - обнаружение симптомов и своевременное обращение за помощью для профилактики ментального здоровья.

![0](https://github.com/straivi/ict-hack-4/blob/main/python-notebook/img/ict_hack7.png) ![0](https://github.com/straivi/ict-hack-4/blob/main/python-notebook/img/ict_hack1.png) ![0](https://github.com/straivi/ict-hack-4/blob/main/python-notebook/img/ict_hack2.png) ![0](https://github.com/straivi/ict-hack-4/blob/main/python-notebook/img/ict_hack3.png)

Две модели машинного обучения:

1) Определение тематики заметки (классификация, дообученный BERT)
2) Советы и рекомендации от психологов на основе текста (cosine similarity)

Для определения психологических проблем данные спарсили из различных соцсетей: из разделов Reddit на темы Депрессии, Тревожности и Суицидальных наклонностей.
Для позитивных отметок сообщество в ВК где люди рассказывают мелочах в повседневной жизни, которые принесли им радость. 

![0](https://github.com/straivi/ict-hack-4/blob/main/python-notebook/img/ict_hack4.png)
![0](https://github.com/straivi/ict-hack-4/blob/main/python-notebook/img/ict_hack5.png)

Для совета взяли готовый датасет CounselChat (counselchat.com) Mental health answers from counselors, с сайта на котором профессиональные психологи дают рекомендации
Эти советы выдаются на заметки, которые классификатор обозначил как depression, anxiety или suicide. Рекомендательная модель выдает максимально подходящий совет из датасета.
